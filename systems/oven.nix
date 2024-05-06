{ flake, pkgs, lib, config, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    inputs.disko.nixosModules.disko
    self.nixosModules.server
    "${self}/nixos/disko/trivial.nix"
    "${self}/nixos/nix.nix"
    "${self}/nixos/self/primary-as-admin.nix"
    "${self}/nixos/server"
    "${self}/nixos/docker.nix"
    "${self}/nixos/virtualisation.nix"
    "${self}/nixos/tailscale.nix"
    "${self}/nixos/nh.nix"
    "${self}/nixos/gnupg.nix"
    # services

    "${self}/nixos/home-assistant.nix"
    #"${self}/nixos/server/minecraft.nix"
  ];

  disko.device = "/dev/sda";

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

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];


  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        libvdpau-va-gl
      ];
    };
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver


  networking = {
    hostName = "oven";
    useDHCP = false;
    dhcpcd.wait = "background";
    dhcpcd.extraConfig = "noarp";
    interfaces.enp3s0 = {
      useDHCP = true;
      wakeOnLan.enable = true;
    };
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  services.openssh.enable = true;

  security.rtkit.enable = true;

  programs.gnupg.agent = {
    pinentryPackage = lib.mkForce pkgs.pinentry-curses;
  };
}
