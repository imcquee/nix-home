{ pkgs }:

with pkgs;
[
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

  # Docker
  docker
  lazydocker

  # CL tools
  lsd
  fzf
  fastfetch
  bottom
  yazi

  # Formatters
  nixfmt-rfc-style
]
