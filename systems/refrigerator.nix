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
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

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

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    keyboard.zsa.enable = true;
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      powerManagement.enable = true;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  networking = {
    hostName = "refrigerator";
    useDHCP = false;
    dhcpcd.wait = "background";
    dhcpcd.extraConfig = "noarp";
    interfaces.enp5s0 = {
      useDHCP = true;
      wakeOnLan.enable = true;
    };
    interfaces.enp6s0 = {
      useDHCP = true;
      wakeOnLan.enable = true;
    };
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  services.openssh.enable = true;
  security.rtkit.enable = true;

  # don't need ALSA
  sound.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  services.ratbagd.enable = true;
  services.fstrim.enable = true;
}
