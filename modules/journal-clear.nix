{
  systemd.timers.journal-vacuum = {
    description = "Vacuum old journal logs daily";

    timerConfig = {
      Persistent = true;
      OnCalendar = "daily";
      Unit = "journal-vacuum.service";
    };
  };

  systemd.services.journal-vacuum = {
    description = "Vacuum old journal logs";

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/journalctl --vacuum-time=7d";
    };
  };
}
