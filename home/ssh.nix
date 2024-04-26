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
        hostname = "100.80.94.22";
      };
    };
    extraConfig = ''
      IgnoreUnknown UseKeychain
      UseKeychain yes
    '';
  };
}
