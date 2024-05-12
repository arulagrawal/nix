{ pkgs, flake, config, ... }: {
  age.secrets.notif = {
    file = ../../secrets/notif.age;
    # mode = "770";
    # owner = "${flake.config.people.myself}";
    # group = "users";
  };

  systemd.user.services.notif = {
    #name = "notif.service";
    Unit = {
      Description = "A service for notif client.";
      Wants = "network-online.target";
      After = "network-online.target";
    };
    #path = [ pkgs.xdg-utils ]; # notif needs xdg-open
    #after = [ "network-online.target" ];
    #wants = [ "network-online.target" ];
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = "${pkgs.notif}/bin/notif";
      EnvironmentFile = "/run/user/1000/agenix/notif";
    };
  };
}
