{ config
, ...
}: {
  # notification daemon
  services.dunst =
    {
      enable = true;
      inherit (config.gtk) iconTheme;
      settings = {
        global = {
          alignment = "left";
          corner_radius = 3;
          follow = "mouse";
          font = "FiraCode Nerd Font Bold 10";
          format = "%s %p\\n%b";
          ignore_newline = "no";
          frame_width = 1;
          #geometry = "0x4-0+0";
          width = ''(50, 400)'';
          scale = 0;
          height = ''(100, 200)'';
          horizontal_padding = 10;
          icon_position = "left";
          origin = "top-right";
          offset = "5x5";
          indicate_hidden = "yes";
          markup = "yes";
          max_icon_size = 64;

          mouse_left_click = "do_action";
          mouse_middle_click = "close_all";
          mouse_right_click = "close_current";
          padding = 8;
          separator_color = "auto";
          separator_height = 1;
          show_indicators = false;
          shrink = "no";
          word_wrap = "yes";
        };

        fullscreen_delay_everything = { fullscreen = "delay"; };

        urgency_critical = {
          background = "#171826";
          foreground = "#2E3440";
          frame_color = "#171826";
          timeout = 4;
        };
        urgency_low = {
          background = "#171826";
          foreground = "#d5dff0";
          frame_color = "#171826";
          timeout = 5;
        };
        urgency_normal = {
          background = "#171826";
          foreground = "#d5dff0";
          frame_color = "#171826";
          timeout = 8;
        };
      };
    };
}
