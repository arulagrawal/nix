{
  flake,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  imports = [
    #inputs.disko.nixosModules.disko
    self.nixosModules.desktop
    #"${self}/nixos/disko/trivial.nix"
    "${self}/nixos/nix.nix"
    "${self}/nixos/gui"
    "${self}/nixos/self/primary-as-admin.nix"
    "${self}/nixos/wifi.nix"
    "${self}/nixos/docker.nix"
    "${self}/nixos/dialout.nix"
    "${self}/nixos/virtualisation.nix"
    "${self}/nixos/tailscale.nix"
    # "${self}/nixos/nordvpn.nix"
    "${self}/nixos/gnupg.nix"
    "${self}/nixos/gaming.nix"
    "${self}/nixos/xdg.nix"
    "${self}/nixos/man.nix"
    "${self}/nixos/nh.nix"
    "${self}/nixos/udev.nix"
    "${self}/nixos/gnome-services.nix"
    "${self}/nixos/avahi.nix"
    "${self}/nixos/printing.nix"
    "${self}/nixos/polkit.nix"
    "${self}/nixos/lanzaboote.nix"
  ];

  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";

  users.users.${flake.config.people.myself} = {
    name = flake.config.people.myself;
    home = "/home/${flake.config.people.myself}";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  programs.command-not-found.enable = false;
  programs.dconf.enable = true;
  nix.package = pkgs.nixVersions.latest;

  environment = {
    shells = with pkgs; [fish];
    pathsToLink = ["/share/fish"];
  };

  # boot stuff
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 6;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = ["amdgpu"];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  specialisation = {
    "xanmod" = {
      inheritParentConfig = true;
      configuration = {
        boot.kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest;
      };
    };
    "stock" = {
      inheritParentConfig = true;
      configuration = {
        boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
      };
    };
  };
  #chaotic.scx.enable = true; # by default uses scx_rustland scheduler
  boot.kernelParams = [
    #   "quiet"
    #   "splash"
    "amd_iommu=off"
    "nvme_core.default_ps_max_latency_us=0"
    #   "amdgpu.noretry=0"
    #   "amdgpu.lockup_timeout=1000"
    #   "amdgpu.gpu_recovery=1"
    #   "iommu=pt"
  ];

  #try kde
  services = {
    desktopManager.plasma6.enable = true;
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      defaultSession = "plasma";
    };
  };
  programs.kdeconnect.enable = true;

  # myypo.services.custom.nordvpn.enable = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7260fc7d-f277-4aaa-b310-02ede2501084";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/37BC-234A";
    fsType = "vfat";
  };

  swapDevices = [];

  services.xserver.videoDrivers = ["amdgpu"];

  hardware = {
    keyboard.zsa.enable = true;
    cpu = {
      intel.updateMicrocode = true;
      x86.msr.enable = true;
    };
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    amdgpu = {
      initrd.enable = true;
      # opencl.enable = true;
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
      };
    };
  };

  # systemd.tmpfiles.rules = [
  #   "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  # ];

  networking = {
    hostName = "refrigerator";
    useDHCP = false;
    usePredictableInterfaceNames = true;
    interfaces = {
      enp8s0.wakeOnLan.enable = true;
      enp9s0.wakeOnLan.enable = true;
      enp8s0.useDHCP = true;
      enp9s0.useDHCP = true;
    };
    dhcpcd.wait = "background";
    dhcpcd.extraConfig = "noarp";
    nameservers = ["1.1.1.1" "1.0.0.1"];
  };
  services.cloudflare-warp.enable = true;

  services.openssh.enable = true;
  security.rtkit.enable = true;

  # needed to save volume?
  #sound.enable = true;
  services.pulseaudio.enable = false;
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

  # udev rule to restore volume settings
  # might need to manually set with alsamixer
  # and then save with sudo alsactl store --ignore
  services.udev.packages = [pkgs.alsa-utils];

  # for razer
  hardware.openrazer = {
    enable = true;
    users = [flake.config.people.myself];
  };

  services.fstrim.enable = true;
}
