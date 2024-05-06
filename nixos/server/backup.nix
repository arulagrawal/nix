{ flake, ... }:
let
  userHome = "/home/${flake.config.people.myself}";
in
{
  services.restic.backups.home = {
    user = "root";
    repository = "";
    # can set empty password because credentials are in env file.
    passwordFile = "";
    environmentFile = "${userHome}/.b2.env";
    paths = [
      "${userHome}/"
    ];
    pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 4"
      "--keep-monthly 2"
      "--keep-yearly 1"
    ];
    timerConfig = {
      OnCalendar = "07:00";
      Persistent = true;
    };
  };
}
