{ userName, ... }:
{
  # # Enable DE
  # services.xserver = {
  #   enable = true;
  #   videoDrivers = [ "nvidia" ];
  # };
  #
  # # Enable Auto-Login
  # services.displayManager = {
  #   gdm = {
  #     enable = true;
  #     wayland = true;
  #     autoSuspend = true;
  #   };
  #   autoLogin = {
  #     enable = true;
  #     user = userName;
  #   };
  # };
  #
  # environment.sessionVariables = {
  #   STEAM_EXTRA_COMPAT_TOOLS_PATHS =
  #     "\${HOME}/.steam/root/compatibilitytools.d";
  # };
  #
  # # Enable Steam
  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  #   dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  #   localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  #   gamescopeSession = {
  #     enable = true;
  #     env = {
  #       # Enable MangoHud
  #       MANGOHUD = "1";
  #       DXVK_HDR = "1";
  #       ENABLE_HDR_WSI = "1";
  #     };
  #     args = [
  #       "-f"
  #       "-w 3840"
  #       "-h 2160"
  #       "-r 120"
  #       "--adaptive-sync"
  #     ];
  #   };
  # };
  #
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  environment.sessionVariables = {
    PROTON_ENABLE_WAYLAND = "1";
    PROTON_ENABLE_HDR = "1";
  };

  jovian = {
    steam = {
      desktopSession = "plasma";
      enable = true;
      # disable until nvidia gamescope session is patched
      # autoStart = true;
      user = userName;
    };
  };

  # Kanata keybindings
  services.kanata = {
    enable = true;
    keyboards.K400.configFile = ../dotfiles/kanata/k400.kbd;
  };

  # Enable Tailscale
  services.tailscale.enable = true;

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
