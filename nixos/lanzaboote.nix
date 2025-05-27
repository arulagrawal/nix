{
  pkgs,
  flake,
  lib,
  ...
}: let
  inherit (flake) inputs;
in {
  imports = [
    flake.inputs.lanzaboote.nixosModules.lanzaboote
  ];
  environment.systemPackages = with pkgs; [
    sbctl
  ];

  boot.loader.systemd-boot = {
    enable = lib.mkForce false;
  };

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    # settings = {
    #   reboot-for-bitlocker = true;
    # };
  };
}
