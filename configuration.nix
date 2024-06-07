{ config, pkgs, lib, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  virtualisation.docker.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;

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

  # Enable nix ld
  programs.nix-ld.enable = true;

  # Enable Fish
  programs.fish.enable = true;

  # Sets up all the libraries to load
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
  ];

  users.users.imcquee = {
    isNormalUser = true;
    description = "Isaac McQueen";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    tmux
    nvidia-docker
    git
    lazygit
    gh
  ];

  # Enable power management services
  powerManagement.powertop.enable = true;
  
  # Enable CPU frequency scaling
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  
  # Enable ACPI and APM
  # powerManagement.cpuFreqGovernorOnAC = "ondemand";
  # powerManagement.cpuFreqGovernorOnBattery = "powersave";
  # powerManagement.powerDownUnusedDisks = true;

  services.tailscale.enable = true;

  system.stateVersion = "24.05";
}

