{pkgs, ...}: let
  exec = "${pkgs.autorestic}/bin/autorestic";
in {
  systemd.user = {
    services.autorestic-backup = {
      Unit.Description = "Autorestic backup service";
      Service = {
        Type = "oneshot";
        ExecStart = "${exec} backup --verbose --all";
        ExecStartPost = "${exec} forget --verbose --all";
        WorkingDirectory = "%h";
      };
    };

    timers.autorestic-backup = {
      Unit.Description = "Backup with autorestic weekly";
      Timer = {
        OnCalendar = "weekly";
        Persistent = true;
      };
      Install.WantedBy = ["timers.target"];
    };

    services.autorestic-prune = {
      Unit.Description = "Autorestic backup service (data pruning)";
      Service = {
        Type = "oneshot";
        ExecStart = "${exec} forget --verbose --all --prune";
        WorkingDirectory = "%h";
      };
    };

    timers.autorestic-prune = {
      Unit.Description = "Prune data from the restic repository monthly";
      Timer = {
        OnCalendar = "monthly";
        Persistent = true;
      };
      Install.WantedBy = ["timers.target"];
    };
  };
}
