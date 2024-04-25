{ pkgs
, lib
, ...
}:
let
  bgImageSection = name: ''
    #${name} {
      background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/${name}.png"));
    }
  '';
in
{
  programs.wlogout = {
    enable = true;

    style = ''
      * {
        background: none;
        background-image: none;
        box-shadow: none;
        color: #89b4fa;
      }

      window {
      	background-color: rgba(0, 0, 0, .5);
      }

      button {
        background: rgba(0, 0, 0, .05);
        border-radius: 8px;
        box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .1), 0 0 rgba(0, 0, 0, .5);
        margin: 1rem;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        outline-style: none;
      }

      button:hover {
        background-color: rgba(255, 255, 255, 0.2);
        outline-style: none;
      }

      ${lib.concatMapStringsSep "\n" bgImageSection [
        "lock"
        "logout"
        "suspend"
        "hibernate"
        "shutdown"
        "reboot"
      ]}
    '';

    layout = [
      {
        "label" = "lock";
        "action" = "loginctl lock-session";
        "text" = "lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "systemctl hibernate";
        "text" = "hibernate";
        "keybind" = "h";
      }
      {
        "label" = "logout";
        "action" = "loginctl terminate-user $USER";
        "text" = "logout";
        "keybind" = "e";
      }
      {
        "label" = "shutdown";
        "action" = "systemctl poweroff";
        "text" = "shutdown";
        "keybind" = "s";
      }
      {
        "label" = "suspend";
        "action" = "systemctl suspend";
        "text" = "suspend";
        "keybind" = "u";
      }
      {
        "label" = "reboot";
        "action" = "systemctl reboot";
        "text" = "reboot";
      }
    ];
  };
}
