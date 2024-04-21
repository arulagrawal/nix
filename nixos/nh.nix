{ config, pkgs, flake, ... }:
let
  user = flake.config.people.myself;
  home = if pkgs.stdenv.isLinux then "/home" else "/Users";
in
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "${home}/${user}/nix";
  };
}
