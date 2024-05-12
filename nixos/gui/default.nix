{ pkgs, ... }: {
  imports = [
    # Isolated features
    ./ddcutil.nix
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
