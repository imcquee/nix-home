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
    wget
    unzip
    nixd
    tree-sitter

    # Fish (needed for home manager standalone)
    fish
    starship

    # Git
    lazygit
    gh

    # CL tools
    lsd
    fzf
    fastfetch
    nerdfonts

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
  ];
in
basePackages
++ pkgs.lib.optionals withGUI [
  # Hyperland
  wofi
  wezterm
  wl-clipboard
  foot

  # Browsers
  firefox

  # Monitoring
  zenith-nvidia
]
