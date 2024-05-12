{ flake, config, lib, ... }:
let
  userHome = "/home/${flake.config.people.myself}";
in
{
  options = {
    restic.time = lib.mkOption {
      type = lib.types.str;
      default = "07:00";
    };
    restic.exclude = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = {
    age.secrets.restic.file = ../../secrets/restic.age;

    services.restic.backups.home = {
      user = "root";
      # can set empty because credentials are in env file.
      repository = "";
      passwordFile = "";
      environmentFile = config.age.secrets.restic.path;
      paths = [
        "${userHome}/"
      ];
      exclude = config.restic.exclude;
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 2"
        "--keep-yearly 1"
      ];
      timerConfig = {
        OnCalendar = config.restic.time;
        Persistent = true;
      };
    };
  };
}
