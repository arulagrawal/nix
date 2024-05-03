# A trivial disk configuration with single root partition taking whole disk
# space.
{ lib, config, ... }:
{
  options = {
    disko.device = lib.mkOption {
      type = lib.types.str;
      default = "/dev/sda";
    };
  };

  config = {
    disko.devices = {
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
}
