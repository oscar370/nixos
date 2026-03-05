{pkgs, ...}: {
  systemd.services.scheduled-shutdown-warn = {
    description = "Notifica y programa el apagado del sistema";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    script = ''
      for user_dir in /run/user/*; do
        uid=$(basename $user_dir)
        if [ -S "$user_dir/bus" ]; then
          ${pkgs.sudo}/bin/sudo -u "#$uid" \
            DBUS_SESSION_BUS_ADDRESS="unix:path=$user_dir/bus" \
            ${pkgs.libnotify}/bin/notify-send "¡Aviso de Apagado!" \
            "El sistema se apagará automáticamente en 5 minutos. Guarda tu trabajo." \
            --urgency=critical \
            --icon=system-shutdown
        fi
      done

      ${pkgs.systemd}/bin/shutdown +5 "Apagado programado por el sistema (22:30)"
    '';
  };

  systemd.timers.scheduled-shutdown-warn = {
    description = "Ejecuta el aviso de apagado a las 22:25";
    timerConfig = {
      OnCalendar = "*-*-* 22:25:00";
      Persistent = true;
      Unit = "scheduled-shutdown-warn.service";
    };
    wantedBy = ["timers.target"];
  };
}
