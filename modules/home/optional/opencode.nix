{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.optional.opencode;
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

    allowedHostPorts = [ 11434 ];
  };
in
{
  options.modules.optional.opencode.enable = lib.mkEnableOption "Opencode for running coding agents locally";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.mcp-nixos
    ];

    programs.opencode = {
      enable = true;
      package = opencodeSandboxed;
      settings = {
        mcp.nixos = {
          type = "local";
          command = [ "mcp-nixos" ];
          environment.MCP_NIXOS_TRANSPORT = "stdio";
        };
        model = "ollama/qwen3-coder:30b";
        provider = {
          ollama = {
            npm = "@ai-sdk/openai-compatible";
            name = "Ollama";
            options = {
              baseURL = "http://127.0.0.1:11434/v1";
            };
            models = {
              "qwen3-coder:30b" = {
                name = "Qwen 3 Coder 30B (Ollama)";
              };
            };
          };
        };
      };
    };
  };
}
