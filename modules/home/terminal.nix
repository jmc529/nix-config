{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
    };
  };

  programs.zellij = {
    enable = true;
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.btop = {
    enable = true;
  };
}
