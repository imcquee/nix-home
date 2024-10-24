{ pkgs, withGUI }:

with pkgs;

let
  basePackages = [
    # these files are meant to be installed in all scenarios

    # Neovim/Mason
    neovim
    fd
    ripgrep
    gcc
    nodejs_20
    cargo
    rustc
    wget
    unzip
    nixd
    tree-sitter
    gnumake

    # Fish (needed for home manager standalone)
    fish
    starship

    # Git
    lazygit
    gh

    # CL tools
    lsd
    fzf
    sd
    fastfetch
    nerdfonts
    font-awesome
    roboto
    source-sans-pro

    # zenith-nvidia
    yazi
    jq
    bat
    difftastic
    gdu
    zoxide
    zellij

    # Docker tools
    lazydocker

    # AI/ML
    oterm

    # Formatters
    nixfmt-rfc-style

    waypaper
    swaybg
  ];
in
basePackages
++ pkgs.lib.optionals withGUI [
  # GUI tools
]
