{
  # Enable DE
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
        autoSuspend = false;
      };
      autoLogin = {
        enable = true;
        user = "imcquee";
      };
    };
  };

  # Enable Hyperland
  programs.hyprland.enable = true;
}
