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

  # CL tools
  lsd
  fzf
  fastfetch
  yazi

  # Formatters
  nixfmt-rfc-style
]
