{ pkgs
, homebrew-core
, homebrew-cask
, homebrew-bundle
, homebrew-jetbrains-utils
, brew-src
, userName
, config
, ...
}:
{
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = true;
      cleanup = "uninstall";
    };
    taps = builtins.map
      (name: if name == "jetbrains/homebrew-utils" then { inherit name; trusted = true; } else name)
      (builtins.attrNames config.nix-homebrew.taps);
    casks = pkgs.callPackage ./casks.nix { };
    brews = [
      "kotlin-lsp"
      "zellij"
    ];
  };

  nix-homebrew = {
    # nix-homebrew labels brew with the version from its own lock file; use ours.
    package =
      let version = (builtins.fromJSON (builtins.readFile ../../flake.lock)).nodes.brew-src.original.ref;
      in brew-src // { name = "brew-${version}"; inherit version; };
    user = userName;
    enable = true;
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;
      "jetbrains/homebrew-utils" = homebrew-jetbrains-utils;
    };
    mutableTaps = false;
    autoMigrate = true;
  };
}
