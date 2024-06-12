{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # Neovim/Mason
    neovim
    fd
    ripgrep
    gcc
    nodejs_20
    cargo
    wget
    unzip

    # Git
    lazygit
    gh

    # Docker
    docker
    lazydocker

    # livebook
    livebook

    # CL tools
    lsd
    fzf
    fastfetch

    # Formatters
    nixfmt-rfc-style
  ];

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

  virtualisation.docker.enable = true;

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

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Enable Tailscale
  services.tailscale.enable = true;

  # Enable vaultwarden
  services.vaultwarden.enable = true;

  # Enable livebook
  # services.livebook = {
  #   enableUserService = true; # Enables the user service for Livebook
  #   environment = {
  #     # Set any necessary environment variables here
  #     LIVEBOOK_IP = "0.0.0.0";
  #     LIVEBOOK_PORT = "8080";
  #   };
  #   package = pkgs.livebook; # Specify the Livebook package to use
  #   # enableUserService = true;
  #   # environment = {
  #   #   LIVEBOOK_SECRET_KEY = "secret";
  #   #   LIVEBOOK_IP = "0.0.0.0";
  #   #   LIVEBOOK_PORT = 8080;
  #   # };
  #   # package = pkgs.livebook;
  # };

  # Enable Livebook
  # systemd.services.livebook = {
  #   enable = true;
  #   description = "livebook";
  #   after = [
  #     "network.target"
  #     "network-online.target"
  #   ];
  #   wants = [ "network-online.target" ];
  #   environment = {
  #     LIVEBOOK_IP = "0.0.0.0";
  #     LIVEBOOK_PORT = "8080";
  #     LIVEBOOK_PASSWORD = "secretpassword";
  #   };
  #   serviceConfig = {
  #     ExecStart = "${pkgs.livebook}/bin/livebook start";
  #     Restart = "on-failure";
  #   };
  #   wantedBy = [ "multi-user.target" ];
  # };

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
      rebuild = "sudo nixos-rebuild switch --flake /home/imcquee/nix-home/#nixos";
      lg = "zellij run -cf --width 80% --height 80% --x 10% --y 10% -- lazygit";
      zj = "zellij";
      ff = "fastfetch";
    };
    shellInit = ''
      fish_vi_key_bindings
    '';
  };

  # Enable Starship
  programs.starship.enable = true;

  users.users.imcquee = {
    isNormalUser = true;
    description = "Isaac McQueen";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable power management services
  powerManagement.powertop.enable = true;

  # Enable CPU frequency scaling
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  system.stateVersion = "24.05";
}
