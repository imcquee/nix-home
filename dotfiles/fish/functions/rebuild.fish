function rebuild
    if test (count $argv) -eq 0
        echo "Usage: rebuild <config>"
        return 1
    end
    set config $argv[1]
    sudo nixos-rebuild switch --flake /home/nixos/nix-home/#$config
end
