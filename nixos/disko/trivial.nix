{ lib, config, ... }:

{
  options = {
    disko = {
      device = {
        default = "/dev/sda";
        type = lib.types.str;
        description = "The device path to use for disk configuration";
      };
    };
  };

  config = {
    disko = {
      devices = {
        disk = {
          main = {
            device = config.disko.device;
            type = "disk";
            content = {
              type = "gpt";
              partitions = {
                boot = {
                  size = "1M";
                  type = "EF02"; # for grub MBR
                };
                ESP = {
                  size = "512M";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                  };
                };
                root = {
                  size = "100%";
                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}

