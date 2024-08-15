{ pkgs, ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
    upgrade = true;
      cleanup = "uninstall";
    };
    casks = pkgs.callPackage ./casks.nix {};
    masApps = {
      "tailscale" = 1475387142;
    };
  };
}
