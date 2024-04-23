{ flake, ... }:
{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;


  users.users.${flake.config.people.myself} = {
    extraGroups = [ "libvirtd" ];
  };
}
