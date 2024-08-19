{
  pkgs,
  config,
  specialArgs,
  ...
}:

let
  inherit (specialArgs)
    withGUI
    homeDir
    userName
    userEmail
    fullName
    ;
in
{
  home.username = userName;
  home.homeDirectory = homeDir;
  home.stateVersion = "24.05";
  home.packages = pkgs.callPackage ./packages.nix { inherit withGUI; };
  programs.home-manager.enable = true;

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

  # Copy symlink for fish 
  home.file.".config/fish".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/fish";

  # Copy symlink for wezterm
  home.file.".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/wezterm";

  # Copy symlink for lazygit
  home.file.".config/lazygit".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/lazygit";

  # Copy symlink for starship
  home.file.".config/starship".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/starship";

  # Copy symlink for hyprland
  home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/hypr";

  # Copy symlink for hyprland
  home.file.".config/kanata".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/kanata";

  # Allow font configuration
  fonts.fontconfig.enable = true;

  programs = {
    git = {
      enable = true;
      userName = fullName;
      userEmail = userEmail;
      ignores = [
        ".envrc"
        ".direnv/"
      ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
