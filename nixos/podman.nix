{ flake, ... }: {
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      dockerSocket.enable = true;
    };
  };


  users.users.${flake.config.people.myself} = {
    extraGroups = [ "podman" ];
  };
}
