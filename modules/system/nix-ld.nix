{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib stdenv.cc.cc openssl curl icu
      libGL vulkan-loader
      libx11 libxrandr libxi libxcursor libxext
      (pkgs.runCommand "steamrun-lib" {} "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
      # add more as things fail — the error message tells you exactly which .so is missing
    ];
  };
}