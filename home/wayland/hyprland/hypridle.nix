{ pkgs, lib, config, ... }:
let
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    ${pkgs.pipewire}/bin/pw-cli i all 2>&1 | ${pkgs.ripgrep}/bin/rg running -q
    # only suspend if audio isn't running
    if [ $? == 1 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
in
{
  # screen idle
  services.hypridle = {
    enable = true;
    settings = {
      #lockCmd = lib.getExe config.programs.hyprlock.package;
      general = {
        lock_cmd = "pidof ${lib.getExe config.programs.hyprlock.package} || ${lib.getExe config.programs.hyprlock.package}";
        before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 60 * 30;
          on-timeout = suspendScript.outPath;
        }
      ];
    };
  };
}

