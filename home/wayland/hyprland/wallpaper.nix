{ pkgs
, lib
, ...
}: {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/images/wallpapers/liz_to_aoi_tori.jpg
    wallpaper = , ~/images/wallpapers/liz_to_aoi_tori.jpg
    splash = false
  '';

  systemd.user.services.hyprpaper = {
    Unit = {
      Description = "Hyprland wallpaper daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}

