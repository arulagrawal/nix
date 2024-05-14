{ pkgs, config, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.foot}/bin/foot";
    theme = "gruvbox-dark";
    extraConfig = {
      modes = mkLiteral "[ combi ]";
      combi-modes = mkLiteral "[ window, drun, run ]";
    };
  };
}
