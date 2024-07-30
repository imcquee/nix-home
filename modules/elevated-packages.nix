{ pkgs, ... }:

{
  # Enable nix ld
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ stdenv.cc.cc ];
  };
}
