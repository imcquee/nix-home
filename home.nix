{ pkgs, config, ... }:

{
  home.username = "imcquee";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # Allow unfree packages with nix-shell
  home.file.".config/nixpkgs/config.nix".text = ''
    {
      allowUnfree = true;
    }
  '';

  # Copy symlink for neovim
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/imcquee/nix-home/dotfiles/nvim";

  # Copy symlink for zellij
  home.file.".config/zellij".source = config.lib.file.mkOutOfStoreSymlink "/home/imcquee/nix-home/dotfiles/zellij";

  # Copy symlink for fish 
  home.file.".config/fish".source = config.lib.file.mkOutOfStoreSymlink "/home/imcquee/nix-home/dotfiles/fish";

  # Copy symlink for wezterm
  home.file.".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink "/home/imcquee/nix-home/dotfiles/wezterm";

  programs = {
    git = {
      enable = true;
      userName = "Isaac McQueen";
      userEmail = "imcqueen@truehomesusa.com";
    };

    zellij.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
