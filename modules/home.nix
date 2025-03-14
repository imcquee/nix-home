{ pkgs
, config
, specialArgs
, ...
}:

let
  inherit (specialArgs) withGUI homeDir userName helix yazi;
in
{
  imports = [ ./programs.nix ];
  home.username = userName;
  home.homeDirectory = homeDir;
  xdg.enable = true;
  home.stateVersion = "24.05";
  home.packages = pkgs.callPackage ./packages.nix { inherit withGUI helix yazi; };
  home.sessionVariables = {
    EDITOR = "hx";
    DIRENV_WARN_TIMEOUT = "0";
    PATH = builtins.concatStringsSep ":" [
      # Default Nix profile binaries
      "${config.home.homeDirectory}/.nix-profile/bin"

      # System-wide Nix profile binaries
      "/nix/var/nix/profiles/default/bin"

      # Include existing PATH
      "$PATH"
    ];
  };

  # Allow unfree packages with nix-shell
  home.file.".config/nixpkgs/config.nix".text = ''
    {
      allowUnfree = true;
    }
  '';

  # Copy symlink for zellij
  home.file.".config/zellij".source =
    config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/zellij";

  # Copy symlink for lazygit
  home.file."${config.xdg.configHome}/lazygit".source =
    config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/lazygit";

  # Copy symlink for hyprland
  home.file.".config/hypr".source =
    config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/hypr";

  # Copy symlink for kanata
  home.file.".config/kanata".source =
    config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/kanata";

  # Copy symlink for MangoHud
  home.file.".config/MangoHud".source =
    config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/MangoHud";

  # Copy symlink for Helix
  home.file.".config/helix".source =
    config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/helix";

  # Copy symlink for Ghostty
  home.file.".config/ghostty".source =
    if pkgs.stdenv.isDarwin then
      config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/ghostty/darwin"
    else
      config.lib.file.mkOutOfStoreSymlink "${homeDir}/nix-home/dotfiles/ghostty/linux";

  # Allow font configuration
  fonts.fontconfig.enable = true;

  services.swayosd.enable = if withGUI then true else false;
}
