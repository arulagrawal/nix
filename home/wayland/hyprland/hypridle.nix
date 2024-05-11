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
  disabledModules = [ "services/hypridle.nix" ];
  # screen idle
  services.hypridle = {
    enable = true;
    #lockCmd = lib.getExe config.programs.hyprlock.package;
    lockCmd = "pidof ${lib.getExe config.programs.hyprlock.package} || ${lib.getExe config.programs.hyprlock.package}";
    beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
    afterSleepCmd = "hyprctl dispatch dpms on";

    listeners = [
      {
        timeout = 60 * 30;
        onTimeout = suspendScript.outPath;
      }
    ];
  };
}

