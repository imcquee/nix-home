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

  programs = {
    git = {
      enable = true;
      userName  = "Isaac McQueen";
      userEmail = "imcqueen@truehomesusa.com";
    };

    tmux = {
      enable = true;
      extraConfig = ''
      set -g mouse on
      setw -g mode-keys vi
      set -sg escape-time 0
      set-option -g status-position top
      set-option -g focus-events on
    
      # Enable true color support
      set -g default-terminal "tmux-256color"
      set -as terminal-features ",*:RGB"
      # Pop up windows
      bind -n M-g display-popup -d "#{pane_current_path}" -w 90% -h 90% -E 'lazygit'
      bind -n M-d display-popup -d "#{pane_current_path}" -w 90% -h 90% -E 'lazydocker'
      '';
    };

   nushell = {
      enable = true;
       # shellAliases = {
       #   vi = "hx";
       #   vim = "hx";
       #   nano = "hx";
       # };
   };  
   carapace.enable = true;
   carapace.enableNushellIntegration = true;

   starship.enable = true;
  };
}
