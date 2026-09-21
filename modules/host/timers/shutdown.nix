{
  config,
  pkgs,
  lib,
  ...
}:
{
  systemd.timers."shutdown" = {
    wantedBy = [ "timers.target" ];
    timerConfig.OnCalendar = "*-*-* 20:00";
  };

  systemd.services."shutdown" = {
    serviceConfig.Type = "oneshot";
    script = "${pkgs.systemd}/bin/systemctl poweroff";
  };

  systemd.user.timers."shutdown-warn" = {
    wantedBy = [ "timers.target" ];
    timerConfig.OnCalendar = "*-*-* 19:45";
  };

  systemd.user.services."shutdown-warn" = {
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.libnotify}/bin/notify-send -u critical "Cierre del día" \
        "El dispositivo se apagará en 15 minutos"
    '';
  };
}
