{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellInit = ''
      touch ~/.hushlogin
      nix-your-shell fish | source
      set fish_greeting
      set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
    '';
    shellAbbrs = {
      ls = "nu -c 'ls'";
      cat = "bat -p";
      lg = "zellij run -cf --width 80% --height 80% --x 10% --y 10% -- lazygit";
      zj = "zellij -l welcome";
      ff = "fastfetch";
      cd = "z";
      nuc = {
        expansion = "nu -c '%'";
        setCursor = "%";
      };
      ghostty = "$GHOSTTY_BIN_DIR/ghostty";
    };
    functions = {
      irg = ''
        set RELOAD "reload:rg --column --color=always --smart-case {q} || :"
        set OPENER "
            if test (count $FZF_SELECT) -eq 0
                $EDITOR {1} +{2}  # No selection. Open the current line in Vim.
            else
                $EDITOR +cw -q (echo {+f})  # Build quickfix list for the selected items.
            end
        "

        fzf --disabled --ansi --multi \
            --bind "start:$RELOAD" --bind "change:$RELOAD" \
            --bind "enter:become:$OPENER" \
            --bind "ctrl-o:execute:$OPENER" \
            --bind "alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview" \
            --delimiter : \
            --preview "bat --style=full --color=always --highlight-line {2} {1}" \
            --preview-window "~4,+{2}+4/3,<80(up)" \
            --query "$argv"
      '';
      rebuild = ''
        if test (count $argv) -eq 0
            echo "Usage: rebuild <config>"
            return 1
        end
        set config $argv[1]

        if command -v nixos-version >/dev/null
            sudo nixos-rebuild switch --flake /home/$USER/nix-home/#$config
        else if string match -q Darwin (uname)
            sudo darwin-rebuild switch --flake /Users/$USER/nix-home#$config
        else
            home-manager switch --flake /home/$USER/nix-home#$config
        end
      '';
      fish_user_key_bindings = ''
        fish_vi_key_bindings
        bind "alt-y" -M insert 'yy; commandline -f execute'
        bind "alt-y" 'yy; commandline -f execute'

        bind "alt-g" -M insert 'commandline -r lazygit; commandline -f execute'
        bind "alt-g" 'commandline -r lazygit; commandline -f execute'
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
    plugins = with pkgs.fishPlugins; [
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }
    ];
  };
}
