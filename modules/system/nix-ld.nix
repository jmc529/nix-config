{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib stdenv.cc.cc openssl curl icu
      libGL vulkan-loader
      libx11 libxrandr libxi libxcursor libxext
      # add more as things fail — the error message tells you exactly which .so is missing
    ];
  };
}