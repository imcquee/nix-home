{
  description = "Nix + Portable Linux + Darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      nix-homebrew,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      ...
    }@inputs:
    let
      # User Information
      userInfo = {
        userName = "imcquee";
        fullName = "Isaac McQueen";
        userEmail = "imcqueen@truehomesusa.com";
      };

      # Common Configurations
      linux_x86 = "x86_64-linux";
      darwin_x86 = "x86_64-darwin";

      # Conditional defaults
      defaults = {
        withGUI = false;
        homeDir = "/home/${userInfo.userName}";
      };

      # Reusable Functions
      configureHomeManager =
        {
          withGUI ? defaults.withGUI,
          homeDir ? defaults.homeDir,
          user ? userInfo,
          ...
        }:
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${userInfo.userName} = import ./modules/home.nix;
          home-manager.extraSpecialArgs = {
            inherit withGUI homeDir user;
          };
        };
    in
    {

      # Configuration for my dev machine
      nixosConfigurations.dev = nixpkgs.lib.nixosSystem {
        system = linux_x86;
        specialArgs = inputs // userInfo // { homeDir = defaults.homeDir; };
        modules = [
          ./hosts/dev/configuration.nix
          ./hosts/dev/hardware-configuration.nix
          ./modules/path.nix
          ./modules/nvidia.nix
          ./modules/services.nix
          ./modules/elevated-packages.nix
          ./modules/hyprland.nix
          home-manager.nixosModules.home-manager
          (configureHomeManager { withGUI = true; })
        ];
      };

      # Darwin Configuration
      darwinConfigurations."MBP2018" = nix-darwin.lib.darwinSystem {
        system = darwin_x86;
        specialArgs = inputs // userInfo // { homeDir = "/Users/${userInfo.userName}"; };
        modules = [
          ./hosts/darwin/configuration.nix
          ./modules/homebrew.nix
          ./modules/path.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              user = userInfo.userName;
              enable = true;
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = homebrew-bundle;
              };
              mutableTaps = false;
              autoMigrate = true;
            };
          }
          home-manager.darwinModules.home-manager
          (configureHomeManager { homeDir = "/Users/${userInfo.userName}"; })
        ];
      };

      # Universal configuration for use in non-nix situations
      homeConfigurations.universal = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = linux_x86;
          config = {
            allowUnfree = true;
          };
        };
        extraSpecialArgs = {
          withGUI = defaults.withGUI;
          homeDir = defaults.homeDir;
          user = userInfo;
        };
        modules = [ ./modules/home.nix ];
      };

      # Build ISO image
      nixosConfigurations.iso = nixpkgs.lib.nixosSystem { modules = [ ./hosts/iso/configuration.nix ]; };
    };
}
