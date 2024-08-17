{
  pkgs,
  config,
  specialArgs,
  ...
}:

let
  inherit (specialArgs) withGUI;
  homeDir = if pkgs.stdenv.isDarwin then "/Users/imcquee" else "/home/imcquee";
in
{
  home.username = "imcquee";
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

  # Home manager programs
  programs = {
    git = {
      enable = true;
      userName = "Isaac McQueen";
      userEmail = "imcqueen@truehomesusa.com";
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
