# Home-manager module: builds Zellij.app (a launcher for `zellij terminal`) in the
# nix store, then copies it into place and codesigns it during activation.
# Signing can't happen inside a nix build (no keychain access, read-only store),
# so it runs in home-manager activation, which has the user's keychain session.
{ config, lib, pkgs, ... }:

let
  cfg = config.programs.zellij-app;

  pythonWithPillow = pkgs.python3.withPackages (ps: [ ps.pillow ]);

  # Pad the (non-square) logo onto a transparent 1024x1024 canvas, with the
  # margin macOS icons normally have, then emit a multi-resolution .icns.
  icns = pkgs.runCommand "zellij-app-icon" { nativeBuildInputs = [ pythonWithPillow ]; } ''
    mkdir -p $out
    python3 -I - ${cfg.icon} $out/Zellij.icns <<'EOF'
    import sys
    from PIL import Image
    src = Image.open(sys.argv[1]).convert("RGBA")
    scale = 860 / max(src.size)
    src = src.resize((round(src.width * scale), round(src.height * scale)), Image.LANCZOS)
    canvas = Image.new("RGBA", (1024, 1024), (0, 0, 0, 0))
    canvas.paste(src, ((1024 - src.width) // 2, (1024 - src.height) // 2), src)
    canvas.save(sys.argv[2], format="ICNS")
    EOF
  '';

  infoPlist = pkgs.writeText "Info.plist" (lib.generators.toPlist { escape = true; } {
    CFBundleName = "Zellij";
    CFBundleDisplayName = "Zellij";
    CFBundleIdentifier = cfg.bundleIdentifier;
    CFBundleExecutable = "Zellij";
    CFBundleIconFile = "Zellij";
    CFBundlePackageType = "APPL";
    CFBundleShortVersionString = cfg.version;
    CFBundleVersion = cfg.version;
    LSMinimumSystemVersion = "11.0";
    LSApplicationCategoryType = "public.app-category.developer-tools";
    NSHighResolutionCapable = true;
  });

  # Run through the login shell so PATH and the environment match a normal terminal.
  # The -c string must parse in fish as well as POSIX shells (fish has no $0/"$@"),
  # so the binary is passed via an env var and no arguments are forwarded.
  launcher = pkgs.writeScript "Zellij" ''
    #!/bin/sh
    cd "$HOME"
    export ZELLIJ_APP_BIN=${lib.escapeShellArg cfg.zellijPath}
    exec "''${SHELL:-/bin/zsh}" -l -c 'exec $ZELLIJ_APP_BIN terminal'
  '';

  app = pkgs.runCommand "Zellij.app" { } ''
    mkdir -p $out/Contents/MacOS $out/Contents/Resources
    cp ${infoPlist} $out/Contents/Info.plist
    cp ${launcher} $out/Contents/MacOS/Zellij
    cp ${icns}/Zellij.icns $out/Contents/Resources/Zellij.icns
    chmod +x $out/Contents/MacOS/Zellij
  '';

  target = "${cfg.installDir}/Zellij.app";
in
{
  options.programs.zellij-app = {
    enable = lib.mkEnableOption "a signed Zellij.app launcher for `zellij terminal`";

    zellijPath = lib.mkOption {
      type = lib.types.str;
      default = "/opt/homebrew/opt/zellij/bin/zellij";
      description = "zellij binary the app launches (default: the Homebrew build).";
    };

    version = lib.mkOption {
      type = lib.types.str;
      default = "0.46.0";
      description = "Version shown in Finder's Get Info.";
    };

    icon = lib.mkOption {
      type = lib.types.path;
      default = ./logo.png;
      description = "PNG used for the app icon; padded to a square automatically.";
    };

    bundleIdentifier = lib.mkOption {
      type = lib.types.str;
      default = "dev.zellij.terminal";
    };

    installDir = lib.mkOption {
      type = lib.types.str;
      default = "/Applications";
    };

    signingIdentity = lib.mkOption {
      type = lib.types.str;
      default = "-";
      description = ''
        codesign identity: a certificate SHA-1 hash or unique name. "-" means
        ad-hoc. Falls back to ad-hoc if the identity isn't in the keychain.
      '';
    };
  };

  config = lib.mkIf (cfg.enable && pkgs.stdenv.isDarwin) {
    home.activation.zellijApp = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      zellijAppStamp=${lib.escapeShellArg "${app}|${cfg.signingIdentity}"}
      zellijAppTarget=${lib.escapeShellArg target}
      zellijAppStampFile="$zellijAppTarget/Contents/Resources/.nix-stamp"

      if [ "$(cat "$zellijAppStampFile" 2>/dev/null)" != "$zellijAppStamp" ]; then
        verboseEcho "Installing and signing $zellijAppTarget"
        identity=${lib.escapeShellArg cfg.signingIdentity}
        if [ "$identity" != "-" ] && ! /usr/bin/security find-identity -v -p codesigning | grep -qF "$identity"; then
          echo "zellij-app: signing identity '$identity' not found, signing ad-hoc" >&2
          identity=-
        fi

        run rm -rf "$zellijAppTarget"
        run /usr/bin/ditto ${app} "$zellijAppTarget"
        run chmod -R u+w "$zellijAppTarget"
        # The stamp lives in Resources, which is sealed by the signature, so write it first.
        if [ -z "''${DRY_RUN:-}" ]; then
          printf '%s' "$zellijAppStamp" > "$zellijAppStampFile"
        fi
        run /usr/bin/codesign --force --options runtime --timestamp=none \
          --sign "$identity" "$zellijAppTarget" \
          || echo "zellij-app: codesign failed (is the login keychain unlocked?)" >&2
        # The keychain keeps listing revoked certificates as valid, but Gatekeeper
        # treats an app signed with one as malware and moves it to the Trash.
        # spctl reports "rejected" for any non-Developer-ID app (harmless for a
        # local app); only a revocation is fatal, so fall back to ad-hoc then.
        if [ -z "''${DRY_RUN:-}" ] && [ "$identity" != "-" ] \
          && /usr/sbin/spctl -a -vv -t exec "$zellijAppTarget" 2>&1 | grep -q REVOKED; then
          echo "zellij-app: certificate '$identity' is revoked; signing ad-hoc instead. Set programs.zellij-app.signingIdentity to a valid certificate." >&2
          run /usr/bin/codesign --force --options runtime --timestamp=none --sign - "$zellijAppTarget"
        fi
        run /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
          -f "$zellijAppTarget" || true
      fi
    '';
  };
}
