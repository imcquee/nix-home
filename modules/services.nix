{ pkgs, ... }:

{
  # Enable Docker
  virtualisation.docker.enable = true;

  # Enable Tailscale
  services.tailscale.enable = true;

  # Enable Ollama
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  # Enable OpenWebUI
  services.open-webui = {
    enable = true;
    host = "0.0.0.0";
    port = 8080;
  };

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
}
