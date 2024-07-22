{ pkgs, lib, ... }:

{
  environment.variables.EDITOR = "nvim";

  nix = {
    # Allow Flakes
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Auto garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    # Optimize storage
    settings.auto-optimise-store = true;
  };

  # Default user
  users.users.imcquee = {
    isNormalUser = true;
    description = "Isaac McQueen";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Configure bootloader to be readable on high resolution displays
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
      gfxmodeEfi = "800x600";
      fontSize = 36;
    };
  };

  # Power management
  powerManagement = {
    # Enable power management services
    powertop.enable = true;
    # Enable CPU frequency scaling
    cpuFreqGovernor = lib.mkDefault "powersave";
  };

  # Netowrking
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # Timezone and locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  system.stateVersion = "24.05";
}
