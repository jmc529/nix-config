{
  services = {
    ollama = {
      enable = true;
      acceleration = "rocm";

      loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b"];
    };

    # http://localhost:8080
    open-webui.enable = true;
  
    local-ai = {
      enable = true;
      environment = {
        # any LocalAI env vars go here — see https://localai.io/basics
        # e.g. LOCALAI_THREADS = "8";
        # e.g. LOCALAI_MODELS_PATH = "/home/you/localai-models";
      };
    };
  };
}