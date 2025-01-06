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
    parsec-bin = pkgs.parsec-bin.overrideAttrs
      {
        src = pkgs.fetchurl {
          url = "https://builds.parsecgaming.com/package/parsec-linux.deb";
          sha256 = "9F56u+jYj2CClhbnGlLi65FxS1Vq00coxwu7mjVTY1w=";
        };
      };
  };

  programs.gamemode.enable = true;
  users.users.${flake.config.people.myself} = {
    extraGroups = [ "gamemode" ];
  };

  environment.systemPackages = with pkgs; [
    inputs.nix-gaming.packages.${system}.wine-tkg
    heroic # launcher for epic, gog and amazon games
    mangohud
    parsec-bin
  ];
}
