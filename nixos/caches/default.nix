{
  imports = [
    # Disable all these caches, because nix is often stuck querying cachix.
    ./nix-gaming.nix
    ./hyprland.nix
    ./anyrun.nix
  ];
}
