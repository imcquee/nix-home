{
  pkgs,
  homebrew-core,
  homebrew-cask,
  homebrew-bundle,
  homebrew-zen-browser,
  userName,
  ...
}:
{
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = true;
      cleanup = "uninstall";
    };
    casks = pkgs.callPackage ./casks.nix { };
    masApps = {
      "tailscale" = 1475387142;
    };
  };

  nix-homebrew = {
    user = userName;
    enable = true;
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;
      "zen-browser/homebrew-browser" = homebrew-zen-browser;
    };
    mutableTaps = false;
    autoMigrate = true;
  };
}
