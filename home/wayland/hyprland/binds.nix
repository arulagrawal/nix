let
  screenshotarea = "hyprctl keyword animation 'fadeOut,0,0,default'; grimblast --notify copysave area; hyprctl keyword animation 'fadeOut,1,4,default'";

  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList
    (
      x:
      let
        ws =
          let
            c = (x + 1) / 10;
          in
          builtins.toString (x + 1 - (c * 10));
      in
      [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
      ]
    )
    10);
in
{
  wayland.windowManager.hyprland.settings = {
    # mouse movements
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];

    # binds
    bind =
      let
        monocle = "dwindle:no_gaps_when_only";
      in
      [
        # compositor commands
        "$mod SHIFT, Escape, exec, pkill Hyprland"
        "$mod, W, killactive,"
        "$mod, F, fullscreen,"
        "$mod, G, togglegroup,"
        "$mod SHIFT, N, changegroupactive, f"
        "$mod SHIFT, P, changegroupactive, b"
        "$mod, R, togglesplit,"
        "$mod, T, togglefloating,"
        "$mod, P, pseudo,"
        "$mod ALT, ,resizeactive,"

        # toggle "monocle" (no_gaps_when_only)
        "$mod, M, exec, hyprctl keyword ${monocle} $(($(hyprctl getoption ${monocle} -j | jaq -r '.int') ^ 1))"

        # utility
        # terminal
        "$mod, Return, exec, foot"
        # logout menu
        "$mod, Escape, exec, wlogout -p layer-shell"
        # lock screen
        "$mod CTRL, L, exec, loginctl lock-session"
        # select area to perform OCR on
        "$mod, O, exec, run-as-service wl-ocr"

        # move focus
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # move window in workspace
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"


        # screenshot
        # stop animations while screenshotting; makes black border go away
        ", Print, exec, screenshot whole"
        "$mod SHIFT, R, exec, screenshot whole"

        "CTRL, Print, exec, screenshot area"
        "$mod SHIFT CTRL, R, exec, screenshot area"

        # special workspace
        "$mod SHIFT, grave, movetoworkspace, special"
        "$mod, grave, togglespecialworkspace, DP-1"

        # cycle workspaces
        "$mod, Q, workspace, m-1"
        "$mod, E, workspace, m+1"

        "$mod SHIFT, Q, movetoworkspacesilent, r-1"
        "$mod SHIFT, E, movetoworkspacesilent, r+1"


        "$mod, X, workspace, previous"

        # cycle monitors
        "$mod SHIFT, bracketleft, focusmonitor, l"
        "$mod SHIFT, bracketright, focusmonitor, r"

        # send focused workspace to left/right monitors
        "$mod SHIFT ALT, bracketleft, movecurrentworkspacetomonitor, l"
        "$mod SHIFT ALT, bracketright, movecurrentworkspacetomonitor, r"

        # clipboard history
        "$mod, V, exec, cliphist list | rofi -dmenu -p clipboard | cliphist decode | wl-copy"
      ]
      ++ workspaces;

    bindr = [
      # launcher
      "$mod, SPACE, exec, rofi -show combi -show-icons"
    ];

    bindl = [
      # media controls
      ", XF86AudioPlay, exec, playerctl --player spotify,playerctld,%any play-pause"
      ", XF86AudioPrev, exec, playerctl --player spotify,playerctld,%any previous"
      ", XF86AudioNext, exec, playerctl --player spotify,playerctld,%any next"

      # volume
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    bindle = [
      # volume
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"
    ];

  };

  wayland.windowManager.hyprland.extraConfig = ''
    bind = $mod, S, submap, rofi-sound

    submap = rofi-sound
    bind=, A, exec, rofi-sound application
    bind=, A, submap, reset
    bind=, D, exec, rofi-sound default
    bind=, D, submap, reset
    bind=, F, exec, rofi-sound default-force
    bind=, F, submap, reset
    bind=,escape,submap,reset 
    submap = reset
  '';


}
