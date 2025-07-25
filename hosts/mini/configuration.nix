{ pkgs
, homeDir
, userName
, ...
}:

{
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
  users = {
    knownUsers = [ userName ];
    users.${userName} = {
      uid = 501;
      name = userName;
      home = homeDir;
      shell = pkgs.fish;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Add device specific packages
  environment.systemPackages = pkgs.callPackage ./packages.nix { };

  # Services
  services = {
    tailscale = {
      enable = true;
    };
  };

  # Daemons
  launchd.user.agents.XcodeClean = {
    serviceConfig = {
      ProgramArguments = [
        ''${pkgs.writeShellScript "clean-xcode" ''
          rm -rf ~/Library/Developer/Xcode/DerivedData
        ''}''
      ];
      StartInterval = 21600;
    };
  };

  system = {
    stateVersion = 5;
    primaryUser = "imcquee";
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
      remapCapsLockToEscape = true;
    };
  };
}

