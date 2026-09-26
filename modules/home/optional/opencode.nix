{ config, lib, pkgs, ... }:
let
  cfg = config.modules.optional.opencode;
in
{
  options.modules.optional.opencode.enable = lib.mkEnableOption "Opencode for running coding agents locally";

  config = lib.mkIf cfg.enable {
    home = {
      packages = [
        pkgs.mcp-nixos
        pkgs.bubblewrap
      ];
    };

    programs.opencode = {
      enable = true;
      settings = {
        lsp = {
          nixd = {
            command = [ "nixd" ];
            extensions = [ ".nix" ];
          };
        };
        mcp.nixos = {
          enabled = true;
          type = "local";
          command = [ "mcp-nixos" ];
          environment.MCP_NIXOS_TRANSPORT = "stdio";
        };
        model = "ollama/glm-4.7-flash";
        share = "disabled";
        formatter = true;
        permission = {
          edit = "ask";
          bash = {
            "git push *" = "ask";
            "rm -rf *" = "deny";
          };
        };
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
                limit = {
                  context = 32768;
                  output = 8192;
                };
              };
              "qwen3-coder:30b" = {
                name = "Qwen 3 Coder 30B";
                limit = {
                  context = 32768;
                  output = 8192;
                };
              };
              "glm-4.7-flash" = {
                name = "GLM 4.7 Flash";
                limit = {
                  context = 32768;
                  output = 8192;
                };
              };
            };
          };
        };
      };
    };
  };
}
