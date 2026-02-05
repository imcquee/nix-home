{ pkgs, ... }:
with pkgs;
[
  jj-starship
  which
  watchman
  android-tools
  zed-editor
  prettierd
  google-cloud-sdk
  macpm
  colima
  docker
  docker-credential-helpers
  postgresql
]
