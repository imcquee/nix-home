{ pkgs
, zen-browser
, ...
}:
with pkgs;
[
  # Terminal
  ghostty

  # VM
  nixos-shell

  # Browser
  zen-browser.packages.x86_64-linux.default

  # EFI Boot Manage
  efibootmgr

  # MangoHud
  mangohud

  # Wayland
  wl-clipboard
  rofi
  waypaper
  swaybg

  # Monitoring
  zenith-nvidia

  # Spotify
  spotify
]
