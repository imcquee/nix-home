{ nixpkgs, pkgs, ... }:
{
  # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
  # remove nix-channel related tools & configs, we use flakes instead.
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

  # but NIX_PATH is still used by many useful tools, so we set it to the same value as the one used by this flake.
  # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
  # https://github.com/NixOS/nix/issues/9574
}
