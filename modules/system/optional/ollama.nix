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
        loadModels = [ "glm-4.7-flash" "qwen3-coder:30b" "gpt-oss:20b" ] ;
        environmentVariables = {
          OLLAMA_MAX_LOADED_MODELS = "1";
          OLLAMA_CONTEXT_LENGTH = "32768";
          OLLAMA_FLASH_ATTENTION = "1";
          OLLAMA_KV_CACHE_TYPE = "q8_0";
          OLLAMA_NUM_GPU_LAYERS = "100";
        };
      };
    };
  };
}
