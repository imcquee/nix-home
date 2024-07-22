{ pkgs, ... }:

{
  # Unstable packages
  environment.systemPackages = with pkgs; [
    # Neovim/Mason
    neovim
    fd
    ripgrep
    gcc
    nodejs_20
    cargo
    wget
    unzip

    # Git
    lazygit
    gh

    # CL tools
    lsd
    fzf
    fastfetch
    zenith-nvidia
    yazi
    jq
    bat

    # Docker tools
    lazydocker

    # AI/ML
    oterm

    # Formatters
    nixfmt-rfc-style
  ];

  # Enable direnv
  programs.direnv.enable = true;

  # Enable nix ld
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ stdenv.cc.cc ];
  };

  # Enable Fish in configuration rather than home so we can set the default login shell to fish in users.users.<user>.shell
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "lsd -t --blocks git,name,size,date --date '+%b %-d, %Y %I:%M%P'";
      cat = "bat";
      lg = "zellij run -cf --width 80% --height 80% --x 10% --y 10% -- lazygit";
      zj = "zellij";
      ff = "fastfetch";
    };
    shellInit = ''
      fish_vi_key_bindings
    '';
  };

  # Enable Starship (needs to be set before home manager is enabled)
  programs.starship.enable = true;
}
