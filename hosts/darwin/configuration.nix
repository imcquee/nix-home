{ pkgs, ... }:

{
  environment.variables.EDITOR = "nvim";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {
    #Add trusted users
    package = pkgs.nix;
    settings.trusted-users = [
      "@admin"
      "imcquee"
    ];
    settings.extra-nix-path = "nixpkgs=flake:nixpkgs";

    # Allow Flakes
    settings.experimental-features = "nix-command flakes repl-flake";

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
    settings.auto-optimise-store = true;
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  # Enable Fish in configuration rather than home so we can set the default login shell to fish in users.users.<user>.shell
  # programs.fish.enable = true;
  programs.zsh.enable = true;

  # Needs to be called near fish
  # programs.starship.enable = true;

  # Default user
  users.users.imcquee = {
    name = "imcquee";
    home = "/Users/imcquee";
    # shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
}
