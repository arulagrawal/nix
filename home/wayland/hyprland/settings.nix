{ config, ... }:
let
  pointer = config.home.pointerCursor;
in
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
    ];

    monitor = "DP-2,2560x1440@144,0x0,1,vrr,1";

    exec-once = [
      # set cursor for HL itself
      "zen"
      "spotify"
      "vesktop"
      #"systemctl --user start clight"
      #"loginctl lock-session"
      # "hyprlock"
    ];

    general = {
      gaps_in = 5;
      gaps_out = 5;
      border_size = 1;
      "col.active_border" = "rgba(88888888)";
      "col.inactive_border" = "rgba(00000088)";

      allow_tearing = true;
      resize_on_border = true;
    };

    decoration = {
      rounding = 16;
      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.02;

        passes = 3;
        size = 10;
      };

      shadow = {
        enabled = true;
        ignore_window = true;
        offset = "0 2";
        range = 20;
        render_power = 3;
        color = "rgba(00000055)";
      };
    };

    animations = {
      enabled = true;
      animation = [
        "border, 1, 2, default"
        "fade, 1, 4, default"
        "windows, 1, 3, default, popin 80%"
        "workspaces, 1, 2, default, slide"
        #"layers, 1, 0.1, default"
        "layers, 0"
      ];
    };

    group = {
      groupbar = {
        font_size = 16;
        gradients = false;
      };

      "col.border_active" = "rgba(d8e2ff88);";
      "col.border_inactive" = "rgba(80aaff88)";
    };

    input = {
      #kb_layout = "ro";

      # focus change on cursor move
      follow_mouse = 0;
      repeat_delay = 300;
      repeat_rate = 50;
      accel_profile = "flat";
      touchpad.scroll_factor = 0.1;
    };

    dwindle = {
      # keep floating dimentions while tiling
      force_split = 2;
      pseudotile = false;
      preserve_split = true;
    };

    misc = {
      # disable auto polling for config file changes
      disable_autoreload = true;

      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;

      # disable dragging animation
      animate_mouse_windowdragging = false;

      # enable variable refresh rate (effective depending on hardware)
      vrr = 1;

    };

    render = {
      direct_scanout = true;
    };

    # touchpad gestures
    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    debug.disable_logs = false;
  };

  wayland.windowManager.hyprland.extraConfig = ''
    env = XDG_SESSION_TYPE,wayland
    env = WLR_DRM_NO_ATOMIC,1
    env = HYPRCURSOR_THEME,${pointer.name}
    env = HYPRCURSOR_SIZE,${toString pointer.size}
  '';
}
