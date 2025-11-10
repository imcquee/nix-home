{
  pkgs,
  withGUI,
  helix,
  neovim-nightly-overlay,
}:

with pkgs;

let

  lazycommit = pkgs.buildGoModule {
    pname = "lazycommit";
    version = "latest";

    src = pkgs.fetchFromGitHub {
      owner = "m7medvision";
      repo = "lazycommit";
      rev = "main";
      sha256 = "sha256-RlAcufMI8Y0LUCjxcYyJnLOWdv2zMbQzhDZRKaVAiN4=";
    };

    vendorHash = "sha256-4OPCUWXxsAnzxsqZPHhjvhxQQf5Knm7nGqrdjH4I4YY=";
    doCheck = false;
  };
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

    # Nerd Fonts
    nerd-fonts.jetbrains-mono

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
