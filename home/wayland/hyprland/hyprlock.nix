{ config, flake, pkgs, ... }:
let
  font_family = "FiraCode Nerd Font";
in
{
  programs.hyprlock = {
    enable = true;
    package = flake.inputs.hyprlock.packages.${pkgs.system}.default;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        no_fade_in = true;
      };

      background = [
        {
          monitor = "";
          path = "${config.home.homeDirectory}/images/wallpapers/resize_liz.jpg";
        }
      ];

      input-field = [
        {
          monitor = "DP-1";

          size = "600, 100";

          position = "0, -400";

          outline_thickness = 2;

          outer_color = "rgb(adc6ff)";
          inner_color = "rgb(d8e2ff)";
          font_color = "rgb(004494)";

          fade_on_empty = false;
          placeholder_text = ''<span font_family="${font_family}" foreground="##004494">...</span>'';

          dots_spacing = 0.3;
          dots_center = true;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          inherit font_family;
          font_size = 150;
          color = "rgb(adc6ff)";

          position = "0, 500";

          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
