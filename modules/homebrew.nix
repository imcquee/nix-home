{
  pkgs,
  inputs,
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
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
    mutableTaps = false;
    autoMigrate = true;
  };
}
