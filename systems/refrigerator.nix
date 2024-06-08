{ flake, pkgs, lib, config, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    #inputs.disko.nixosModules.disko
    self.nixosModules.desktop
    inputs.solaar.nixosModules.default
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

  system.stateVersion = "24.11";
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

  #boot.kernelPackages = pkgs.linuxPackages_cachyos;
  # boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  #chaotic.scx.enable = true; # by default uses scx_rustland scheduler
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

  # chaotic.mesa-git = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     mesa_git.opencl
  #
  #
  #     libva
  #     vaapiVdpau
  #     libvdpau-va-gl
  #   ];
  #   extraPackages32 = with pkgs.pkgsi686Linux; [
  #     pkgs.mesa32_git.opencl
  #
  #     libva
  #     vaapiVdpau
  #     libvdpau-va-gl
  #   ];
  # };
  hardware = {
    keyboard.zsa.enable = true;
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        amdvlk

        rocmPackages.clr.icd
        rocmPackages.clr
        rocmPackages.rocminfo
        rocmPackages.rocm-runtime

        libva
        vaapiVdpau
        libvdpau-va-gl
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        amdvlk

        libva
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  environment.variables = {
    # VAAPI and VDPAU config for accelerated video.
    # See https://wiki.archlinux.org/index.php/Hardware_video_acceleration
    "VDPAU_DRIVER" = "radeonsi";
    "LIBVA_DRIVER_NAME" = "radeonsi";
  };


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

  # for logitech mouse
  programs.solaar.enable = true;
  services.fstrim.enable = true;
}
