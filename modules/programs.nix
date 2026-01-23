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
      settings = {
        user = {
          name = fullName;
          email = userEmail;
        };
      };
      enable = true;
      ignores = [
        ".claude/"
        ".envrc"
        ".direnv/"
      ];
    };

    jujutsu = {
      enable = true;
      settings = {
        user = {
          name = fullName;
          email = userEmail;
        };
        snapshot = {
          max-new-file-size = "15M";
        };
        ui = {
          default-command = "log";
          merge-editor = "vimdiff";
          conflict-marker-style = "snapshot";
        };
        merge-tools = {
          vimdiff = {
            program = "nvim";
          };
        };
        aliases = {
          push = [
            "git"
            "push"
            "--allow-new"
          ];
          res = [
            "resolve"
            "--tool"
            "vimdiff"
          ];
          sync = [
            "git"
            "fetch"
          ];
          rb = [
            "util"
            "exec"
            "--"
            "sh"
            "-c"
            "jj rebase -r @ -d \"$1\""
            ""
          ];
          desc = [
            "util"
            "exec"
            "--"
            "sh"
            "-c"
            "jj describe -m \"$(lazycommit pr \"$1\" | sed -n '1p')\""
            ""
          ];
          sb = [
            "bookmark"
            "set"
          ];
          # - jj sn <revision> - sync and create new change
          # - jj sn <revision> <bookmark-name> - sync, create new change, and set bookmark
          sn = [
            "util"
            "exec"
            "--"
            "sh"
            "-c"
            "git fetch && jj new \"$1\" && if [ -n \"$2\" ]; then jj bookmark set \"$2\"; fi"
            ""
          ];
        };
      };
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

    atuin = {
      enable = true;
      enableFishIntegration = true;
    };

    nushell.enable = true;
  };
}
