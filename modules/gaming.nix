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
        ENABLE_HDR_WSI = "1";
      };
      args = [
        "-f"
        "-w 3840"
        "-h 2160"
        "-r 120"
        "--hdr-enabled"
        "--adaptive-sync"
        "--hdr-itm-enable"
      ];
    };
  };

  # Kanata keybindings
  services.kanata = {
    enable = true;
    keyboards.K400.configFile = /home/${userName}/nix-home/dotfiles/kanata/k400.kbd;
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
