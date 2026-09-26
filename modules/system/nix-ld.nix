{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib stdenv.cc.cc openssl curl icu
      libGL vulkan-loader libGLU fontconfig
      libx11 libxrandr libxi libxcursor libxext
      libxkbcommon libxcb libxshmfence
      (pkgs.runCommand "steamrun-lib" {} "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib") 
    ];
  };
}