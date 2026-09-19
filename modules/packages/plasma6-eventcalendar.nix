{ lib, stdenv, fetchFromGitHub, cmake, kdePackages }:

stdenv.mkDerivation {
  pname = "plasma6-applet-eventcalendar";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "lenonk";
    repo = "plasma6-applet-eventcalendar";
    rev = "master";
    hash = "sha256-HrviyYM1IrChyGgpaEZVLgDTOkIB+nzeKyb49vD4WCs=";
  };

  nativeBuildInputs = [
    cmake
    kdePackages.extra-cmake-modules
    kdePackages.wrapQtAppsHook
  ];

  buildInputs = [
    kdePackages.qtbase
    kdePackages.qtnetworkauth   # for the browser-based Google login helper
    kdePackages.libplasma
  ];

  meta = {
    description = "Event Calendar widget for Plasma 6";
    homepage = "https://github.com/lenonk/plasma6-applet-eventcalendar";
    platforms = lib.platforms.linux;
  };
}