{ specialArgs, ... }:

let
  inherit (specialArgs) fullName userEmail;
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

    starship.enable = true;
    zoxide.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
