{ lib, pkgs, config, ... }:
{
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
  } // lib.optionalAttrs pkgs.stdenv.isLinux {
    # yes i'm that guy
    download = "${config.home.homeDirectory}/downloads";
    pictures = "${config.home.homeDirectory}/images";
  };
}
