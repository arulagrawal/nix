{
  services.yabai = {
    enable = true;
    config = {
      mouse_follows_focus = "off";
      focus_follows_mouse = "off";
      window_placement = "second_child";
      window_opacity = "off";
      window_opacity_duration = 0.0;
      window_shadow = "on";
      active_window_opacity = 1.0;
      normal_window_opacity = 1.0;
      split_ratio = 0.5;
      auto_balance = "off";
      mouse_modifier = "ctrl";
      mouse_action1 = "move";
      mouse_action2 = "resize";

      layout = "bsp";
      #external_bar           = " all:20:0";
      top_padding = 5;
      bottom_padding = 20;
      left_padding = 20;
      right_padding = 20;
      window_gap = 10;
    };
    extraConfig = builtins.readFile ./yabai_rules;
  };
}
