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
    tree-sitter
    gnumake

    # Language Servers
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
    sd
    fastfetch
    font-awesome
    roboto
    source-sans-pro
    nix-your-shell

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
    nixpkgs-fmt

    # Helix
    helix
    nushell
  ];
in
basePackages
++ pkgs.lib.optionals withGUI [
  # GUI tools
]
