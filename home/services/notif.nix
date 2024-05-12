{ pkgs, ... }: {
  age.secrets.notif = {
    file = ../../secrets/notif.age;
  };

  systemd.user.services.notif = {
    Unit = {
      Description = "A service for notif client";
      Wants = "network-online.target";
      After = "network-online.target";
    };
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = "${pkgs.notif}/bin/notif";
      EnvironmentFile = "/run/user/1000/agenix/notif";
    };
  };
}
