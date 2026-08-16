{ pkgs
, homebrew-core
, homebrew-cask
, homebrew-bundle
, homebrew-jetbrains-utils
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
    ];
  };

  nix-homebrew = {
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
