{flake, ...}: {
  users.users.${flake.config.people.myself} = {
    extraGroups = ["dialout"];
  };
}
