{ pkgs, config, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.foot}/bin/foot";
    theme = {
      "*" = {
        font = "FiraCode Nerd Font Medium 14";
        bg0 = mkLiteral "#1a1b26";
        bg1 = mkLiteral "#1f2335";
        bg2 = mkLiteral "#24283b";
        bg3 = mkLiteral "#414868";
        fg0 = mkLiteral "#c0caf5";
        fg1 = mkLiteral "#a9b1d6";
        fg2 = mkLiteral "#737aa2";
        red = mkLiteral "#f7768e";
        green = mkLiteral "#9ece6a";
        yellow = mkLiteral "#e0af68";
        blue = mkLiteral "#7aa2f7";
        magenta = mkLiteral "#9a7ecc";
        cyan = mkLiteral "#4abaaf";

        accent = mkLiteral "@red";
        urgent = mkLiteral "@yellow";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";

        margin = 0;
        padding = 0;
        spacing = 0;
      };
      "element-icon, element-text, scrollbar" = {
        cursor = mkLiteral "pointer";
      };

      "window" = {
        location = mkLiteral "north";
        width = mkLiteral "500px";
        # x-offset = mkLiteral "4px";
        y-offset = mkLiteral "500px";

        background-color = mkLiteral "@bg1";
        border = mkLiteral "1px";
        border-color = mkLiteral "@bg3";
        border-radius = mkLiteral "6px";
      };

      "inputbar" = {
        spacing = mkLiteral "8px";
        padding = mkLiteral "4px 8px";
        children = mkLiteral "[ prompt, entry ]";

        background-color = mkLiteral "@bg0";
      };

      "icon-search, entry, element-icon, element-text" = {
        vertical-align = mkLiteral "0.5";
      };

      "icon-search" = {
        expand = mkLiteral "false";
        filename = "search-symbolic";
        size = mkLiteral "14px";
      };

      "textbox" = {
        padding = mkLiteral "4px 8px";
        background-color = mkLiteral "@bg2";
      };

      "listview" = {
        padding = mkLiteral "4px 0px";
        lines = mkLiteral "12";
        columns = mkLiteral "1";
        scrollbar = mkLiteral "false";
        fixed-height = mkLiteral "false";
        dynamic = mkLiteral "true";
      };

      "element" = {
        padding = mkLiteral "4px 8px";
        spacing = mkLiteral "8px";
      };

      "element normal urgent" = {
        text-color = mkLiteral "@urgent";
      };

      "element normal active" = {
        text-color = mkLiteral "@accent";
      };

      "element selected" = {
        text-color = mkLiteral "@bg1";
        background-color = mkLiteral "@accent";
      };

      "element selected urgent" = {
        background-color = mkLiteral "@urgent";
      };

      "element-icon" = {
        size = mkLiteral "0.8em";
      };

      "element-text" = {
        text-color = mkLiteral "inherit";
      };

      "scrollbar" = {
        handle-width = mkLiteral "0px";
        handle-color = mkLiteral "@fg2";
        padding = mkLiteral "0 4px";
      };
    };
    extraConfig = {
      modes = mkLiteral "[ combi ]";
      combi-modes = mkLiteral "[ window, drun, run ]";
    };
  };

  home.packages = with pkgs; [
    rofi-sound
  ];
}
