{ pkgs, ... }:

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

  # Enable Livebook
  # services.livebook = {
  #   enableUserService = true;
  #   environment = {
  #     # CUDA_PATH = "${pkgs.cudatoolkit}";
  #     # CUDA_DIR = "${pkgs.cudatoolkit}";
  #     # NVVM_LIB_PATH = "${pkgs.cudatoolkit}/nvvm/libdevice";
  #     # XLA_FLAGS = "--xla_gpu_cuda_data_dir=${pkgs.cudatoolkit}";
  #     # LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.cudatoolkit}/lib:${pkgs.cudaPackages.cudnn}/lib:${pkgs.cudatoolkit.lib}/lib:/run/opengl-driver/lib:$LD_LIBRARY_PATH";
  #     LIVEBOOK_PORT = 1025;
  #     LIVEBOOK_IFRAME_PORT = 1026;
  #     LIVEBOOK_IP = "0.0.0.0";
  #     LIVEBOOK_PASSWORD = "secretpassword";
  #   };
  # };

  # Enable Envfs
  services.envfs.enable = true;
}
