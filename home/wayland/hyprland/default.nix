{ flakes, pkgs, ... }: {
  imports = [
    ./binds.nix
    ./rules.nix
    ./settings.nix
    ./wallpaper.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./anyrun
  ];

  home.packages = [
    pkgs.grimblast
  ];

  # enable hyprland
  wayland.windowManager.hyprland = {
    enable = true;

    # plugins = [inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix];

    systemd = {
      variables = [ "--all" ];
    };
  };
}
