{ pkgs
, homebrew-core
, homebrew-cask
, homebrew-bundle
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
    taps = builtins.attrNames config.nix-homebrew.taps;
    casks = pkgs.callPackage ./casks.nix { };
  };

  nix-homebrew = {
    user = userName;
    enable = true;
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;
    };
    mutableTaps = false;
    autoMigrate = true;
  };
}
