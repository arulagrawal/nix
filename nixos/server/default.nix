{ lib, ... }:
{
  imports = [
    ./utc.nix
    ./harden
  ];

  fonts.fontconfig.enable = lib.mkDefault false;
  sound.enable = false;

  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
}
