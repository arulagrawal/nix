{ pkgs, lib, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "kettle" = {
        user = "arul";
        hostname = "kettle.arul.io";
      };
      "airfryer" = {
        user = "ubuntu";
        hostname = "airfryer.arul.io";
      };
      "oven" = {
        user = "arul";
        hostname = "100.85.105.81";
      };
    };
    extraConfig = ''
      IgnoreUnknown UseKeychain
      UseKeychain yes
    '';
  };
}
