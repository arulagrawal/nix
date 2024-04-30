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
    extraOptionOverrides = {
      setEnv = "TERM=xterm-256color";
    };
    extraConfig = ''
      IgnoreUnknown UseKeychain
      UseKeychain yes
    '';
  };
}
