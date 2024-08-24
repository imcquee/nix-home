{ pkgs, specialArgs, ... }:

let
  inherit (specialArgs) userName fullName userEmail;
in
{
  imports = [ ./fish.nix ];
  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = fullName;
      userEmail = userEmail;
      ignores = [
        ".envrc"
        ".direnv/"
      ];
    };

    firefox = {
      enable = true;
      profiles.${userName} = {
        isDefault = true;
        name = userName;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          darkreader
          vimium-c
        ];
      };
    };

    starship.enable = true;
    zoxide.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
