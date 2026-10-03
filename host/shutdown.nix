{ pkgs, ... }:
{
  # Power off every day at 20:00
  systemd.timers.shutdown = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "20:00";
      Unit = "poweroff.target";
    };
  };

  # Warn 15 minutes before
  systemd.user.timers.shutdown-warn = {
    wantedBy = [ "timers.target" ];
    timerConfig.OnCalendar = "19:45";
  };

  systemd.user.services.shutdown-warn = {
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.libnotify}/bin/notify-send -u critical "Cierre del día" \
        "El dispositivo se apagará en 15 minutos"
    '';
  };
}
