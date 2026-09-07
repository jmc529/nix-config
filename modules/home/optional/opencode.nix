{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.optional.opencode;
  # https://github.com/archie-judd/agent-sandbox.nix
  agentSandbox = import inputs.agent-sandbox-nix { inherit pkgs; };

  opencodeSandboxed = agentSandbox.mkSandbox {
    pkg = pkgs.opencode;
    binName = "opencode";
    outName = "opencode";

    allowedPackages = agentSandbox.commonTools ++ [
      pkgs.git
      pkgs.nodejs
      pkgs.mcp-nixos
    ];

    rwDirs = [
      "$HOME/.config/opencode"
      "$HOME/.local/share/opencode"
    ];

    roFiles = [ "$HOME/.config/git/config" ];

    # Ollama and mcp-nixos (if it ever needs to phone home) live locally;
    # 11434 is the port that actually matters for talking to Ollama
    allowedHostPorts = [ 11434 ];
  };
in
{
  options.modules.optional.opencode.enable = lib.mkEnableOption "Opencode for running coding agents locally";

  config = lib.mkIf cfg.enable {
    home.packages = [
      # nix mcp (AI model context protocol) gives info on nix https://github.com/utensils/mcp-nixos
      pkgs.mcp-nixos
      opencodeSandboxed
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