{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    configType = "hyprlang";

    # Usamos extraConfig para garantizar sintaxis pura en hyprland.conf
    extraConfig = ''
      input {
        kb_layout = es
      }

      exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = caelestia-shell
    '';
  };

  programs.caelestia = {
    enable = true;
    systemd.enable = false;

    settings = {
      bar.statusIcons = [
        { id = "lockStatus"; enabled = true; }
        { id = "network"; enabled = true; }
        { id = "bluetooth"; enabled = true; }
        { id = "battery"; enabled = true; }
      ];
      paths.wallpaperDir = "~/Imagenes/Wallpapers";
    };

    cli.enable = true;
  };
}