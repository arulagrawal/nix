{ config, pkgs, lib, ... }:
{
  hardware.video.hidpi.enable = true;
  services.xserver.dpi = 170;
}
