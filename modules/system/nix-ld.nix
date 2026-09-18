{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib stdenv.cc.cc openssl curl icu
      libGL vulkan-loader
      xorg.libX11 xorg.libXrandr xorg.libXi xorg.libXcursor xorg.libXext
      # add more as things fail — the error message tells you exactly which .so is missing
    ];
  };
}