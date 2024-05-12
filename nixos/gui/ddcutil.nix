{ pkgs, ... }:
{
  # for display control (brightness etc.)
  hardware.i2c.enable = true;
  environment.systemPackages = [ pkgs.ddcutil ];
}
