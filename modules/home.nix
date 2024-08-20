{
  pkgs,
  config,
  specialArgs,
  ...
}:

let
  inherit (specialArgs) withGUI homeDir userName;
in
{
  imports = [ ./programs.nix ];
  home.username = userName;
  home.homeDirectory = homeDir;
  home.stateVersion = "24.05";
  home.packages = pkgs.callPackage ./packages.nix { inherit withGUI; };
  home.sessionVariables = {
    EDITOR = "nvim";
    # Set this to avoid issues when login shell is set to non bash
    PATH = "${config.home.homeDirectory}/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH";
  };

  # Allow unfree packages with nix-shell
  home.file.".config/nixpkgs/config.nix".text = ''
    {
      allowUnfree = true;
    }
  '';

  # Copy symlink for neovim
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/nvim";

  # Copy symlink for zellij
  home.file.".config/zellij".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/zellij";

  # Copy symlink for wezterm
  home.file.".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/wezterm";

  # Copy symlink for lazygit
  home.file.".config/lazygit".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/lazygit";

  # Copy symlink for hyprland
  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/hypr";

  # Copy symlink for kanata
  home.file.".config/kanata".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/kanata";

  # Allow font configuration
  fonts.fontconfig.enable = true;
}
