{
  # Enable DE
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  # Enable Hyperland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
