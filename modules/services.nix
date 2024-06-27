{
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

  # Enable Envfs
  services.envfs.enable = true;
}
