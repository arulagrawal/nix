{ flake, pkgs, lib, config, modulesPath, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    inputs.disko.nixosModules.disko
    self.nixosModules.server
    "${self}/nixos/disko/trivial-with-swap.nix"
    "${self}/nixos/nix.nix"
    "${self}/nixos/self/primary-as-admin.nix"
    "${self}/nixos/docker.nix"
    "${self}/nixos/tailscale.nix"
    "${self}/nixos/xdg.nix"
    "${self}/nixos/nh.nix"
    "${self}/nixos/gnupg.nix"
  ];

  disko.device = "/dev/vda";

  system.stateVersion = "23.11";
  nixpkgs.hostPlatform = "x86_64-linux";

  users.users.${flake.config.people.myself} = {
    name = flake.config.people.myself;
    home = "/home/${flake.config.people.myself}";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  programs.command-not-found.enable = false;

  environment = {
    shells = with pkgs; [ fish ];
    pathsToLink = [ "/share/fish" ];
  };

  # boot stuff
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  hardware = {
    enableRedistributableFirmware = true;
  };

  networking = {
    hostName = "kettle";
    useDHCP = false;
    interfaces.ens3 = {
      useDHCP = true;
      ipv6.addresses = [{
        address = "2a03:4000:1a:1f1::1";
        prefixLength = 64;
      }];
    };
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  networking.firewall.allowedTCPPorts = [ 80 443 7000 ];
  networking.firewall.allowedUDPPorts = [ 443 ];

  services.openssh.enable = true;
  security.rtkit.enable = true;

  programs.gnupg.agent = {
    pinentryPackage = lib.mkForce pkgs.pinentry-curses;
  };
}
