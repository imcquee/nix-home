{ pkgs, specialArgs, ... }:

let
  inherit (specialArgs)
    userName
    fullName
    userEmail
    withGUI
    ;
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

    firefox =
      if withGUI then
        {
          enable = true;
          profiles.${userName} = {
            isDefault = true;
            name = userName;
            extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
              ublock-origin
              bitwarden
              darkreader
              vimium-c
            ];
          };
        }
      else
        { enable = false; };

    starship = {
      enable = true;
      settings = pkgs.lib.importTOML ../dotfiles/starship/starship.toml;
    };

    zoxide.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    nushell.enable = true;
  };
}
