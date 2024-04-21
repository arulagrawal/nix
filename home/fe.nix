{ flake, pkgs, ... }:
{
  home.packages = [ flake.inputs.fe.defaultPackage.${pkgs.system} ];
}
