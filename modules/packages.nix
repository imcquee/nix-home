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
      sha256 = "sha256-FPtkdIEXwNNC86ZfAakND9SJb+bSQyle6kviLTzqXuM=";
    };

    vendorHash = "sha256-4OPCUWXxsAnzxsqZPHhjvhxQQf5Knm7nGqrdjH4I4YY=";
    doCheck = false;
  };

  maestro-runner-unwrapped = pkgs.buildGoModule {
    pname = "maestro-runner";
    version = "latest";

    src = pkgs.fetchFromGitHub {
      owner = "devicelab-dev";
      repo = "maestro-runner";
      rev = "main";
      sha256 = "sha256-5BJwtUy/jVFuhpdfCMTzE3qXF8TVREAOVbhyMwKWKig";
    };

    vendorHash = "sha256-lcaVLKqF0p2xsSOfyRGSvrYHT5RnZ7/YghadFJ1wFiw=";
    doCheck = false;
  };

  maestro-runner = pkgs.symlinkJoin {
    name = "maestro-runner";
    paths = [ maestro-runner-unwrapped ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/maestro-runner \
        --run 'export MAESTRO_RUNNER_HOME="$HOME/.local/share/maestro-runner"'
    '';
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

    # Mobile testing
    maestro-runner

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
    nixfmt-rfc-style
    nixpkgs-fmt

    # DB
    pspg

    # Use Helix from the flake input instead of pkgs.helix
    helix.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Neovim nightly
    neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default

    spotifyd
    opencode
  ];
in
basePackages
++ pkgs.lib.optionals withGUI [
  # GUI tools
]
