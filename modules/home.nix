{
  pkgs,
  config,
  specialArgs,
  ...
}:

let
  inherit (specialArgs) withGUI;
in
{
  home.username = "imcquee";
  home.homeDirectory = "/home/imcquee";
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
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/imcquee/nix-home/dotfiles/nvim";

  # Copy symlink for zellij
  home.file.".config/zellij".source = config.lib.file.mkOutOfStoreSymlink "/home/imcquee/nix-home/dotfiles/zellij";

  # Copy symlink for fish 
  home.file.".config/fish".source = config.lib.file.mkOutOfStoreSymlink "/home/imcquee/nix-home/dotfiles/fish";

  # Copy symlink for wezterm
  home.file.".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink "/home/imcquee/nix-home/dotfiles/wezterm";

  # Copy symlink for lazygit
  home.file.".config/lazygit".source = config.lib.file.mkOutOfStoreSymlink "/home/imcquee/nix-home/dotfiles/lazygit";

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
      enableFishIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  };
}
