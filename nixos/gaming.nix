{ pkgs, flake, ... }:

let
  inherit (flake) inputs;
in
{
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge
  ];
}
