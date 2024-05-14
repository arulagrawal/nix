{ pkgs, flake, ... }:
# Wayland config
{
  imports = [
    ./hyprland
    ./foot.nix
    ./gtk.nix
    ./wlogout.nix
    ./dunst.nix
    ./wlsunset.nix
    ./rofi.nix

    ./obs.nix
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

    flake.inputs.hyprpaper.packages.${pkgs.system}.default
    screenshot
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
