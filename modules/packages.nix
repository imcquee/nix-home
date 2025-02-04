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
    nushell
    aider-chat

    # zenith-nvidia
    yazi
    bat
    zoxide
    zellij

    # Docker tools
    lazydocker

    # Formatters
    nixfmt-rfc-style
    nixpkgs-fmt

    # Use Helix from the flake input instead of pkgs.helix
    helix.packages.${pkgs.system}.default
  ];
in
basePackages
++ pkgs.lib.optionals withGUI [
  # GUI tools
]
