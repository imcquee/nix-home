{ pkgs, config, ... }:

{
  home.username = "imcquee";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName  = "Isaac McQueen";
    userEmail = "imcqueen@truehomesusa.com";
  };
}
