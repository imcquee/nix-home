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
      nixpkgs,
      home-manager,
      nix-darwin,
      nix-homebrew,
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
          ./modules/home-manager.nix
        ];
      };

      # Darwin Configuration
      darwinConfigurations."MBP2018" = nix-darwin.lib.darwinSystem {
        system = darwin_x86;
        specialArgs =
          inputs
          // userInfo
          // {
            withGUI = defaults.withGUI;
            homeDir = "/Users/${userInfo.userName}";
          };
        modules = [
          ./hosts/darwin/configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          ./modules/homebrew.nix
          ./modules/path.nix
          home-manager.darwinModules.home-manager
          ./modules/home-manager.nix
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
