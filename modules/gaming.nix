{ pkgs, userName, ... }:

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

  # Enable Tailscale
  services.tailscale.enable = true;

  # Enable Auto-Login
  services.displayManager.autoLogin = {
    enable = true;
    user = userName;
  };

  # Enable sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession = {
      enable = true;
      env = {
        # Enable MangoHud
        MANGOHUD = "1";
        DXVK_HDR = "1";
      };
      args = [
        "-f"
        "-w 3840"
        "-h 2160"
        "-r 120"
        "--adaptive-sync"
      ];
    };
  };
}
