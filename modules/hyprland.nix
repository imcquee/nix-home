{ userName, ... }:

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
    };
  };

  # Enable Auto-Login
  services.displayManager.autoLogin = {
    enable = true;
    user = userName;
  };

  # Enable Hyperland
  programs.hyprland.enable = true;
}
