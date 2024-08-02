{ lib, ... }:
{
  imports = [
    ./utc.nix
    ./harden
    ./backup.nix
  ];

  fonts.fontconfig.enable = lib.mkDefault false;

  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
}
