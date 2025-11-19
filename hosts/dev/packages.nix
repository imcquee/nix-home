{
  pkgs,
  zen-browser,
  ...
}:
with pkgs;
[
  # Terminal
  ghostty

  # Wayland
  xwayland-satellite

  # VM
  nixos-shell

  # Browser
  zen-browser.packages.x86_64-linux.default

  # EFI Boot Manage
  efibootmgr

  # MangoHud
  mangohud

  # Proton
  protonup-ng

  # Wayland
  wl-clipboard
  rofi
  waypaper
  swaybg

  # Monitoring
  zenith-nvidia

  # Niri
  fuzzel

  # Spotify
  spotify
]
