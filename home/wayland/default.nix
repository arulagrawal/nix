{ pkgs
, ...
}:
# Wayland config
{
  imports = [
    ./hyprland
    ./foot.nix
    ./gtk.nix
    ./wlogout.nix
  ];

  home.packages = with pkgs; [
    # screenshot
    #grim
    #slurp

    # utils
    #self.packages.${pkgs.system}.wl-ocr
    wl-clipboard
    wl-screenrec
    wlr-randr
    hyprpaper
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
