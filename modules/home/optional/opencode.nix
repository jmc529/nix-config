{ config, lib, pkgs, ... }:
let
  cfg = config.modules.optional.opencode;
in
{
  options.modules.optional.opencode.enable = lib.mkEnableOption "Opencode for running coding agents locally";
  
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # nix mcp (AI model context protocal) gives info on nix https://github.com/utensils/mcp-nixos
      mcp-nixos
    ];

    programs.opencode = {
      # https://opencode.ai/
      enable = true;
      settings = {
        mcp.nixos = {
          type = "local";
          command = [ "mcp-nixos" ];
          environment.MCP_NIXOS_TRANSPORT = "stdio";
        };
        model = "ollama/qwen2.5-coder:14b";
        provider = {
          ollama = {
            npm = "@ai-sdk/openai-compatible";
            name = "Ollama";
            options = {
              baseURL = "http://127.0.0.1:11434/v1";
            };
            models = {
              "qwen2.5-coder:14b" = {
                name = "Qwen 2.5 Coder 14B (Ollama)";
              };
            };
          };
        };
      };
    };
  };
}