{
  description = "NixOS + Portable Linux + Darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    helix.url = "github:helix-editor/helix/master";
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
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    nur.url = "github:nix-community/NUR";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-darwin,
      nix-homebrew,
      nur,
      helix,
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
      linux_ARM = "aarch64-linux";
      darwin_x86 = "x86_64-darwin";
      darwin_ARM = "aarch64-darwin";

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
        specialArgs =
          inputs
          // userInfo
          // {
            withGUI = true;
            homeDir = defaults.homeDir;
          };
        modules = [
          ./hosts/dev/configuration.nix
          ./hosts/dev/hardware-configuration.nix
          ./modules/path.nix
          ./modules/nvidia.nix
          ./modules/services.nix
          ./modules/elevated-packages.nix
          ./modules/hyprland.nix
          { nixpkgs.overlays = [ nur.overlays.default ]; }
          home-manager.nixosModules.home-manager
          ./modules/home-manager.nix
        ];
      };

      # Configuration for my gaming machine
      nixosConfigurations.gaming = nixpkgs.lib.nixosSystem {
        system = linux_x86;
        specialArgs =
          inputs
          // userInfo
          // {
            withGUI = true;
            homeDir = defaults.homeDir;
          };
        modules = [
          ./hosts/dev/configuration.nix
          ./hosts/dev/hardware-configuration.nix
          ./modules/path.nix
          ./modules/nvidia.nix
          ./modules/elevated-packages.nix
          ./modules/gaming.nix
          { nixpkgs.overlays = [ nur.overlays.default ]; }
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
          ./hosts/MBP2018/configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          ./hosts/MBP2018/homebrew.nix
          ./modules/path.nix
          home-manager.darwinModules.home-manager
          ./modules/home-manager.nix
        ];
      };

      # Darwin Configuration
      darwinConfigurations."mini" = nix-darwin.lib.darwinSystem {
        system = darwin_ARM;
        specialArgs =
          inputs
          // userInfo
          // {
            withGUI = defaults.withGUI;
            homeDir = "/Users/${userInfo.userName}";
          };
        modules = [
          ./hosts/mini/configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          ./hosts/mini/homebrew.nix
          ./modules/path.nix
          home-manager.darwinModules.home-manager
          ./modules/home-manager.nix
        ];
      };

      # Darwin Configuration
      darwinConfigurations."MBA2025" = nix-darwin.lib.darwinSystem {
        system = darwin_ARM;
        specialArgs =
          inputs
          // userInfo
          // {
            withGUI = defaults.withGUI;
            homeDir = "/Users/${userInfo.userName}";
          };
        modules = [
          ./hosts/MBA2025/configuration.nix
          nix-homebrew.darwinModules.nix-homebrew
          ./hosts/MBA2025/homebrew.nix
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
          helix = inputs.helix;
        } // userInfo;
        modules = [ ./modules/home.nix ];
      };

      # Build ISO image
      nixosConfigurations.iso = nixpkgs.lib.nixosSystem { modules = [ ./hosts/iso/configuration.nix ]; };
    };
}
