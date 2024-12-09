{
  pkgs,
  homeDir,
  userName,
  ...
}:

let
  pinnedNixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/e89cf1c932006531f454de7d652163a9a5c86668.tar.gz";
    sha256 = "09cbqscrvsd6p0q8rswwxy7pz1p1qbcc8cdkr6p6q8sx0la9r12c";
  };

  pinnedPkgs = import pinnedNixpkgs {
    system = pkgs.system;
    config = { };
  };
in
{
  environment.variables.EDITOR = "nvim";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {
    #Add trusted users
    package = pkgs.nix;
    settings.trusted-users = [
      "@admin"
      userName
    ];
    settings.extra-nix-path = "nixpkgs=flake:nixpkgs";
    # Allow Flakes
    settings.experimental-features = "nix-command flakes";

    # Auto garbage collection
    gc = {
      user = "root";
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };

    # Optimize storage
    optimise.automatic = true;
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  # Setup both fish and zsh to avoid issues when switching
  programs.fish.enable = true;
  programs.zsh.enable = true;
  programs.direnv = {
    enable = true;
    loadInNixShell = true;
  };

  # Default user
  users.users.${userName} = {
    name = userName;
    home = homeDir;
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Use Touch ID over sudo
  security.pam.enableSudoTouchIdAuth = true;

  # Add unstable packages + pinned packages
  # Kanata version requires https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/blob/main/dist/Karabiner-DriverKit-VirtualHIDDevice-3.1.0.pkg
  environment.systemPackages = pkgs.callPackage ./packages.nix { } ++ [ pinnedPkgs.kanata ];

  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
      };
      dock = {
        autohide = true;
        tilesize = 56;
        orientation = "left";
        persistent-apps = [ "/System/Applications/Messages.app" ];
      };
      finder = {
        AppleShowAllExtensions = true;
        NewWindowTarget = "Home";
        ShowPathbar = true;
      };
      screencapture.location = "~/Pictures/Screenshots";
    };

    keyboard = {
      enableKeyMapping = true;
      # remapCapsLockToEscape = true;
    };
  };
}
