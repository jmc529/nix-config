{ config, lib, pkgs, ... }:

let
  cfg = config.modules.optional.ollama;
in
{
  options.modules.optional.ollama.enable = lib.mkEnableOption "ollama support (AI)";

  config = lib.mkIf cfg.enable {
    services = {
      ollama = {
        enable = true;
        package = pkgs.ollama-rocm;
        loadModels = [ "qwen3-coder:30b" "gpt-oss:20b" ] ;
        environmentVariables = {
          OLLAMA_CONTEXT_LENGTH = "32768";
          OLLAMA_FLASH_ATTENTION = "1";
          OLLAMA_KV_CACHE_TYPE = "q8_0";   # halves KV cache memory
          # HSA_OVERRIDE_GFX_VERSION = "11.0.0";  # only if the GPU isn't detected
        };
      };

      # http://localhost:11434/ - ollama status
      # http://localhost:8080/ - ai chat webpage
      open-webui.enable = true;
    };
  };
}
