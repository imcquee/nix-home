{ pkgs
, withGUI
, helix
, neovim-nightly-overlay
,
}:

with pkgs;

let
  basePackages = [
    # these files are meant to be installed in all scenarios

    # Neovim
    gcc
    gnumake
    cargo
    rustc
    wget
    unzip
    tree-sitter
    nodejs_20

    # Language Servers for nix (where else would I put these?)
    nixd
    nil

    # Fish (needed for home manager standalone)
    fish
    starship

    # Git
    lazygit
    gh
    jujutsu

    # CL tools
    fzf
    fd
    ncdu
    ripgrep
    fastfetch
    font-awesome
    roboto
    source-sans-pro
    nix-your-shell
    yazi
    bat
    zoxide
    zellij
    serpl
    ffmpeg
    pandoc
    # zenith-nvidia

    # Docker tools
    lazydocker

    # Formatters
    nixfmt-rfc-style
    nixpkgs-fmt

    # Use Helix from the flake input instead of pkgs.helix
    helix.packages.${pkgs.system}.default

    # Neovim nightly
    neovim-nightly-overlay.packages.${pkgs.system}.default
  ];
in
basePackages
++ pkgs.lib.optionals withGUI [
  # GUI tools
]
