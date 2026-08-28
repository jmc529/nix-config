{ config, lib, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    acceleration = "rocm";
  };

  # http://localhost:8080
  services.open-webui.enable = true;
}