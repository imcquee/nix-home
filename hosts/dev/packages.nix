{
  pkgs,
  ghostty,
  zen-browser,
  ...
}:
with pkgs;
[
  # Terminal
  ghostty.packages.x86_64-linux.default

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
  rofi-wayland

  # Monitoring
  zenith-nvidia
]
