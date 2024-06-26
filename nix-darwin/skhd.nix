{
  services.skhd = {
    enable = true;
    keybindings = {
      # open iterm
      "alt - return" = "/Users/arul/scripts/iterm2";
      # alt - return : open -na WezTerm

      #alt - return : open -na kitty --args -1
      #cmd - return : open -na kitty --args -1

      # open vscode
      # cmd + shift - return : code

      # take a screenshot
      "cmd + shift - 3" = "screenshot whole";
      "cmd + shift - 4" = "screenshot area";

      # focus window
      "alt - h" = "yabai -m window --focus west";
      "alt - l" = "yabai -m window --focus east";
      "alt - j" = "yabai -m window --focus south";
      "alt - k" = "yabai -m window --focus north";

      # swap managed window
      "shift + alt - h" = "yabai -m window --swap west";
      "shift + alt - l" = "yabai -m window --swap east";
      "shift + alt - j" = "yabai -m window --swap south";
      "shift + alt - k" = "yabai -m window --swap north";

      # move managed window
      "meh - h" = "yabai -m window --warp west";
      "meh - l" = "yabai -m window --warp east";
      "meh - j" = "yabai -m window --warp south";
      "meh - k" = "yabai -m window --warp north";

      # balance size of windows
      "shift + alt - 0" = "yabai -m space --balance";

      # rotate tree
      "alt - r" = "yabai -m space --rotate 90";

      # make floating window fill screen
      # shift + alt - up     : yabai -m window --grid 1:1:0:0:1:1

      # make floating window fill left-half of screen
      # shift + alt - left   : yabai -m window --grid 1:2:0:0:1:1

      # create desktop, move window and follow focus - uses jq for parsing json (brew install jq)
      # shift + cmd - n : yabai -m space --create && \
      #                   index="$(yabai -m query --spaces --display | jq 'map(select(."native-fullscreen" == 0))[-1].index')" && \
      #                   yabai -m window --space "${index}" && \
      #                   yabai -m space --focus "${index}"

      # fast focus desktop
      "alt - x" = "yabai -m space --focus recent";
      "alt - 1" = "yabai -m space --focus 1";
      "alt - 2" = "yabai -m space --focus 2";
      "alt - 3" = "yabai -m space --focus 3";
      "alt - 4" = "yabai -m space --focus 4";
      "alt - 5" = "yabai -m space --focus 5";
      "alt - 6" = "yabai -m space --focus 6";
      "alt - 7" = "yabai -m space --focus 7";
      "alt - 8" = "yabai -m space --focus 8";

      # focus on next/prev occupied window
      "alt - q" = "nextprev prev";
      "alt - e" = "nextprev next";

      # focus on next/prev window
      "alt + ctrl - q" = "yabai -m space --focus prev";
      "alt + ctrl - e" = "yabai -m space --focus next";

      # send window to next/prev window
      "alt + shift - q" = "yabai -m window --space prev";
      "alt + shift - e" = "yabai -m window --space next";

      # send window to desktop
      "shift + alt - x" = "yabai -m window --space recent";
      "shift + alt - 1" = "yabai -m window --space 1";
      "shift + alt - 2" = "yabai -m window --space 2";
      "shift + alt - 3" = "yabai -m window --space 3";
      "shift + alt - 4" = "yabai -m window --space 4";
      "shift + alt - 5" = "yabai -m window --space 5";
      "shift + alt - 6" = "yabai -m window --space 6";
      "shift + alt - 7" = "yabai -m window --space 7";
      "shift + alt - 8" = "yabai -m window --space 8";
      #
      # focus monitor
      # ctrl + alt - z  : yabai -m display --focus prev
      # ctrl + alt - 3  : yabai -m display --focus 3

      # send window to monitor and follow focus
      # ctrl + cmd - c  : yabai -m window --display next; yabai -m display --focus next
      # ctrl + cmd - 1  : yabai -m window --display 1; yabai -m display --focus 1

      # move floating window
      # shift + ctrl - a : yabai -m window --move rel:-20:0
      # shift + ctrl - s : yabai -m window --move rel:0:20

      # control window size, modified to be intuitive
      "alt + ctrl - h" = "yabai -m window --resize left:-20:0 || yabai -m window --resize right:-20:0";
      "alt + ctrl - l" = "yabai -m window --resize right:20:0 || yabai -m window --resize left:20:0";
      "alt + ctrl - j" = "yabai -m window --resize bottom:0:20 || yabai -m window --resize top:0:20";
      "alt + ctrl - k" = "yabai -m window --resize top:0:-20 || yabai -m window --resize bottom:0:-20";

      # set insertion point in focused container
      # ctrl + alt - h : yabai -m window --insert west

      # toggle window zoom
      # alt - d : yabai -m window --toggle zoom-parent
      # alt - f : yabai -m window --toggle zoom-fullscreen

      # toggle window split type
      # alt - e : yabai -m window --toggle split

      # float / unfloat window and center on screen
      "alt - t" = "yabai -m window --toggle float; yabai -m window --grid 4:4:1:1:2:2";

      # go zoom fullscreen
      "alt - f" = "yabai -m window --toggle zoom-fullscreen";

      # close window yabai way, not overriding system default
      "alt - w" = "yabai -m window --close";

      # sticky a window
      "alt - s" = "yabai -m window --toggle float; yabai -m window --toggle sticky";
    };
  };
}
