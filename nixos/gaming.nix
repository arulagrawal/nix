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

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        libgdiplus
        keyutils
        libkrb5
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    inputs.nix-gaming.packages.${system}.wine-ge
    heroic # launcher for epic, gog and amazon games
  ];
}
