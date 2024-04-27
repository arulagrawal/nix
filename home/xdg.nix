{ lib, pkgs, config, ... }:
lib.mkMerge [
  { xdg.enable = true; }
  (lib.mkIf pkgs.stdenv.isLinux {
    xdg.userDirs = {
      enable = true;
      download = "${config.home.homeDirectory}/downloads";
      pictures = "${config.home.homeDirectory}/images";
    };
  })
]
