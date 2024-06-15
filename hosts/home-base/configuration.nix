{ pkgs, lib, ... }:

{
  environment.systemPackages = import ../../modules/packages.nix { inherit pkgs; };

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

  # Allow Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Auto garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

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

  # Enable power management services
  powerManagement.powertop.enable = true;

  # Enable CPU frequency scaling
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

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

  # Enable Docker
  virtualisation.docker.enable = true;

  # Enable direnv
  programs.direnv.enable = true;

  # Enable nix ld
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ stdenv.cc.cc ];

  # Enable Fish in configuration rather than home so we can set the default login shell to fish in users.users.<user>.shell
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "lsd -t --blocks git,name,size,date --date '+%b %-d, %Y %I:%M%P'";
      lg = "zellij run -cf --width 80% --height 80% --x 10% --y 10% -- lazygit";
      zj = "zellij";
      ff = "fastfetch";
    };
    shellInit = ''
      fish_vi_key_bindings
    '';
  };

  # Enable Starship (needs to be set before home manager is enabled)
  programs.starship.enable = true;

  system.stateVersion = "24.05";
}
