function rebuild
    if test (count $argv) -eq 0
        echo "Usage: rebuild <config>"
        return 1
    end
    set config $argv[1]

    if test -e /etc/NIXOS
        sudo nixos-rebuild switch --flake /home/$USER/nix-home/#$config
    else if string match -q Darwin (uname)
        darwin-rebuild switch --flake /home/$USER/nix-home#$config
    else
        home-manager switch --flake /home/$USER/nix-home#$config
    end
end
