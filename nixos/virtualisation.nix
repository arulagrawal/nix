{ flake, ... }:
{
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  users.users.${flake.config.people.myself} = {
    extraGroups = [ "libvirtd" ];
  };
}
