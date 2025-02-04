{
  pkgs,
  userName,
  homeDir,
  ...
}:

{
  # Enable Docker
  virtualisation.docker.enable = true;

  # Enable Tailscale
  services.tailscale.enable = true;

  # Enable Ollama
  # services.ollama = {
  #   enable = true;
  #   acceleration = "cuda";
  # };
  #
  # # Enable OpenWebUI
  # services.open-webui = {
  #   enable = true;
  #   host = "0.0.0.0";
  #   port = 8080;
  # };

  # Enable Nginx
  services.nginx = {
    enable = true;

    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  # Let's Encrypt
  security.acme = {
    acceptTerms = true;
    defaults.email = "foo@bar.com";
  };

  # Enable Envfs
  services.envfs.enable = true;

  # Kanata keybindings
  services.kanata = {
    enable = true;
    keyboards.K400.configFile = ../dotfiles/kanata/k400.kbd;
  };

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
