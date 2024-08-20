{ specialArgs, ... }:

let
  inherit (specialArgs) fullName userEmail;
in
{
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

    fish = {
      enable = true;
      shellAbbrs = {
        ls = "lsd -t --blocks git,name,size,date --date '+%b %-d, %Y %I:%M%P'";
        cat = "bat -p";
        lg = "zellij run -cf --width 80% --height 80% --x 10% --y 10% -- lazygit";
        zj = "zellij";
        ff = "fastfetch";
      };
      functions = {
        rebuild = ''
          if test (count $argv) -eq 0
              echo "Usage: rebuild <config>"
              return 1
          end
          set config $argv[1]

          if command -v nixos-version >/dev/null
              sudo nixos-rebuild switch --flake /home/$USER/nix-home/#$config
          else if string match -q Darwin (uname)
              darwin-rebuild switch --flake /Users/$USER/nix-home#$config
          else
              home-manager switch --flake /home/$USER/nix-home#$config
          end
        '';
        fish_user_key_bindings = ''
          fish_vi_key_bindings
          bind \ey -M insert 'yy; commandline -f execute'
          bind \ey 'yy; commandline -f execute'

          bind \eg -M insert 'lazygit; commandline -f execute'
          bind \eg 'lazygit; commandline -f execute'
        '';
        original_cd = ''
          builtin cd $argv
        '';
        yy = ''
          set tmp (mktemp -t "yazi-cwd.XXXXXX")
          yazi $argv --cwd-file="$tmp"
          if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
              original_cd -- "$cwd"
          end
          rm -f -- "$tmp"

        '';

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
