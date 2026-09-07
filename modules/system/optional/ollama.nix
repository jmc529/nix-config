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
        loadModels = [ "qwen2.5-coder:14b"] ;
      };

      # http://localhost:11434/ - ollama status
      # http://localhost:8080/ - ai chat webpage
      open-webui.enable = true;
    };
  };
}