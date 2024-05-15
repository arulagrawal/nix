{ flake, pkgs, lib, config, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    #inputs.disko.nixosModules.disko
    self.nixosModules.desktop
    #"${self}/nixos/disko/trivial.nix"
    "${self}/nixos/nix.nix"
    "${self}/nixos/gui"
    "${self}/nixos/self/primary-as-admin.nix"
    "${self}/nixos/docker.nix"
    "${self}/nixos/virtualisation.nix"
    "${self}/nixos/tailscale.nix"
    "${self}/nixos/gnupg.nix"
    "${self}/nixos/gaming.nix"
    "${self}/nixos/xdg.nix"
    "${self}/nixos/nh.nix"
    "${self}/nixos/udev.nix"
    "${self}/nixos/gnome-services.nix"
    "${self}/nixos/avahi.nix"
    "${self}/nixos/polkit.nix"
  ];

  system.stateVersion = "23.11";
  nixpkgs.hostPlatform = "x86_64-linux";

  users.users.${flake.config.people.myself} = {
    name = flake.config.people.myself;
    home = "/home/${flake.config.people.myself}";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  programs.command-not-found.enable = false;
  programs.dconf.enable = true;

  environment = {
    shells = with pkgs; [ fish ];
    pathsToLink = [ "/share/fish" ];
  };


  # boot stuff
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.kernelParams = [
    "quiet"
    "splash"
    "iommu=pt"
  ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/7260fc7d-f277-4aaa-b310-02ede2501084";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/37BC-234A";
      fsType = "vfat";
    };

  swapDevices = [ ];

  services.xserver.videoDrivers = [ "modesetting" ];

  hardware = {
    keyboard.zsa.enable = true;
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        rocmPackages.clr
        rocm-opencl-runtime
        rocm-opencl-icd

        libva
        vaapiVdpau
        libvdpau-va-gl
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  networking = {
    hostName = "refrigerator";
    useDHCP = true;
    interfaces = {
      enp7s0.wakeOnLan.enable = true;
      enp8s0.wakeOnLan.enable = true;
    };
    dhcpcd.wait = "background";
    dhcpcd.extraConfig = "noarp";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  services.openssh.enable = true;
  security.rtkit.enable = true;

  # don't need ALSA
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  services.ratbagd.enable = true;
  services.fstrim.enable = true;
}
