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

  # Use Touch ID over sudo + sudo
  security = {
    pam.services.sudo_local.touchIdAuth = true;
    sudo.extraConfig = ''
      ${userName} ALL=(ALL) NOPASSWD: ${pinnedPkgs.kanata}/bin/kanata
    '';
  };

  # Daemons
  launchd.user.agents.kanata = {
    command = "/usr/bin/sudo ${pinnedPkgs.kanata}/bin/kanata -c ${homeDir}/nix-home/dotfiles/kanata/MBA.kbd";
    serviceConfig = {
      UserName = userName;
      RunAtLoad = true;
      KeepAlive = {
        SuccessfulExit = false;
        Crashed = true;
      };
      StandardErrorPath = "/Users/${userName}/.logs/kanata.err.log";
      StandardOutPath = "/Users/${userName}/.logs/kanata.out.log";
      ProcessType = "Interactive";
      Nice = -30;
    };
  };

  # Add unstable packages + pinned packages
  # Kanata version requires https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice/blob/main/dist/Karabiner-DriverKit-VirtualHIDDevice-3.1.0.pkg
  # After installation run `/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate`
  environment.systemPackages = pkgs.callPackage ./packages.nix { } ++ [ pinnedPkgs.kanata ];

  # https://stackoverflow.com/questions/79371917/direnv-printing-environment-diff-even-with-hide-env-diff-true
  environment.etc."direnv/direnv.toml".text = ''
    [global]
    hide_env_diff = true
    warn_timeout = 0
    log_filter="^$"
  '';

  environment.variables.ANDROID_HOME = "/Users/imcquee/Library/Android/sdk";

  system = {
    stateVersion = 5;
    primaryUser = "imcquee";
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        _HIHideMenuBar = true;
      };
      dock = {
        autohide = true;
        tilesize = 56;
        orientation = "bottom";
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
