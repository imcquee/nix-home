{
  description = "Nix + Darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      # Configuration for my dev machine
      nixosConfigurations.dev = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./hosts/dev/configuration.nix
          ./hosts/dev/hardware-configuration.nix
          ./modules/path.nix
          ./modules/nvidia.nix
          ./modules/services.nix
          ./modules/elevated-packages.nix
          ./modules/hyprland.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.imcquee = import ./modules/home.nix;
            home-manager.extraSpecialArgs = {
              withGUI = true;
            };
          }
        ];
      };

      # Universal configuration for use in non-nix situations
      homeConfigurations.universal = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = {
            allowUnfree = true;
          };
        };
        extraSpecialArgs = {
          withGUI = false;
        };
        modules = [ ./modules/home.nix ];
      };

      # Build ISO image
      nixosConfigurations.iso = nixpkgs.lib.nixosSystem { modules = [ ./hosts/iso/configuration.nix ]; };
    };
}
