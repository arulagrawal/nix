{ flake, pkgs, ... }:
{
  imports = [
    flake.inputs.hyprland.nixosModules.default
  ];
  environment.variables.NIXOS_OZONE_WL = "1";

  # enable hyprland and required options
  programs.hyprland = {
    enable = true;
    package = flake.inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
}
