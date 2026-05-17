{
  pkgs,
  withGUI,
  helix,
  neovim-nightly-overlay,
}:

with pkgs;

let

  basePackages = [
    # these files are meant to be installed in all scenarios

    # Neovim
    lua-language-server
    neovim-remote
    gcc
    gnumake
    cargo
    rustc
    wget
    unzip
    tree-sitter
    nodejs_22
    dwt1-shell-color-scripts

    # AI nonsense
    copilot-language-server
    github-copilot-cli
    claude-code

    # Nerd Fonts
    nerd-fonts.jetbrains-mono

    # Language Servers for nix (where else would I put these?)
    nixd
    nil
    codebook

    # Fish (needed for home manager standalone)
    fish
    starship

    # Git
    lazygit
    gh
    lazycommit

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
    jjui
    # zenith-nvidia

    # Docker tools
    lazydocker

    # Formatters
    nixpkgs-fmt

    # DB
    pspg

    # Use Helix from the flake input instead of pkgs.helix
    helix.packages.${pkgs.stdenv.hostPlatform.system}.default

    neovim
    # Neovim nightly
    # neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default

    spotifyd
    opencode
  ];
in
basePackages
++ pkgs.lib.optionals withGUI [
  # GUI tools
]
