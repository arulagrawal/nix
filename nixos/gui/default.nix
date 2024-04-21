{ pkgs, ... }: {
  imports = [
    # Isolated features
    #./hidpi.nix
    ./hyprland.nix
    ./thunar.nix
    ./apps.nix
    ./fonts.nix
    ./greetd.nix
  ];

  services = {
    flatpak.enable = true;
    xserver.enable = true;
  };
}
