{ flake, ... }:
{
  virtualisation.libvirtd.enable = true;

  users.users.${flake.config.people.myself} = {
    extraGroups = [ "libvirtd" ];
  };
}
