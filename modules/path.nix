{ nixpkgs, pkgs, ... }:
{
  # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
  # remove nix-channel related tools & configs, we use flakes instead.
  # Use flake for nix_path https://nixos-and-flakes.thiscute.world/best-practices/nix-path-and-flake-registry
  nix =
    if pkgs.stdenv.isDarwin then
      {
        registry.nixpkgs.flake = nixpkgs;
        settings.nix-path = nixpkgs.lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      }
    else
      {
        nix.channel.enable = false;
        registry.nixpkgs.flake = nixpkgs;
        settings.nix-path = nixpkgs.lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      };
  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
}
