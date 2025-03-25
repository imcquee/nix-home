{ pkgs, withGUI, helix }:

with pkgs;

let
  basePackages = [
    # these files are meant to be installed in all scenarios

    # Language Servers for nix (where else would I put these?)
    nixd
    nil

    # Fish (needed for home manager standalone)
    fish
    starship

    # Git
    lazygit
    gh

    # CL tools
    fzf
    fd
    ripgrep
    fastfetch
    font-awesome
    roboto
    source-sans-pro
    nix-your-shell
    aider-chat
    yazi
    bat
    zoxide
    zellij
    serpl
    # zenith-nvidia

    # Docker tools
    lazydocker

    # Formatters
    nixfmt-rfc-style
    nixpkgs-fmt

    # Editors
    helix.packages.${pkgs.system}.default
    neovim
  ];
in
basePackages
++ pkgs.lib.optionals withGUI [
  # GUI tools
]
