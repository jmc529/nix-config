{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.optional.opencode;
in
{
  options.modules.optional.opencode.enable = lib.mkEnableOption "Opencode for running coding agents locally";

  config = lib.mkIf cfg.enable {
    home = {
      file = {
        ".config/opencode/.keep".text = "";
        ".local/share/opencode/.keep".text = "";
      };

      packages = [
        pkgs.mcp-nixos
      ];
    };

    programs.opencode = {
      enable = true;
      settings = {
        mcp.nixos = {
          type = "local";
          command = [ "mcp-nixos" ];
          environment.MCP_NIXOS_TRANSPORT = "stdio";
        };
        model = "ollama/gpt-oss:20b";
        provider = {
          ollama = {
            npm = "@ai-sdk/openai-compatible";
            name = "Ollama";
            options = {
              baseURL = "http://127.0.0.1:11434/v1";
            };
            models = {
              "gpt-oss:20b" = {
                name = "GPT-OSS 20B";
                limit = { context = 32768; output = 8192; };
              };
              "qwen3-coder:30b" = {
                name = "Qwen 3 Coder 30B";
                limit = { context = 32768; output = 8192; };
              };
            };
          };
        };
      };
    };
  };
}
