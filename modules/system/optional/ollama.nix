{ config, lib, ... }:

let
  cfg = config.modules.optional.ollama;
in
{
  options.modules.optional.ollama.enable = lib.mkEnableOption "ollama support (AI)";

  config = lib.mkIf cfg.enable {
    services = {
      ollama = {
        enable = true;
        acceleration = "rocm";
#         May need this if Ollama doesn't detect the 7800 XT correctly under ROCm (some RDNA3 cards need a gfx-version override)
#         environmentVariablesHSA_OVERRIDE_GFX_VERSION = "11.0.0";
        loadModels = [ "qwen3-coder:30b" "gpt-oss:20b" ] ;
      };

      # http://localhost:11434/ - ollama status
      # http://localhost:8080/ - ai chat webpage
      open-webui.enable = true;
    };
  };
}
