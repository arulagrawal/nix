{ pkgs, flake, ... }:

let
  inherit (flake) inputs;
in
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    gamescopeSession.enable = true;
  };
  environment.systemPackages = with pkgs; [
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge
  ];
}
