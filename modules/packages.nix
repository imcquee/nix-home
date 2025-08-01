{
  pkgs,
  withGUI,
  helix,
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
    # zenith-nvidia

    # Docker tools
    lazydocker

    # Formatters
    nixfmt-rfc-style
    nixpkgs-fmt

    # Use Helix from the flake input instead of pkgs.helix
    helix.packages.${pkgs.system}.default

    # Neovim
    neovim
  ];
in
basePackages
++ pkgs.lib.optionals withGUI [
  # GUI tools
]
