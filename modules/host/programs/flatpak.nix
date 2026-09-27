{
  config,
  pkgs,
  lib,
  timeZone,
  ...
}:
{
  services.flatpak = {
    enable = true;

    packages = [
      "io.github.kolunmi.Bazaar"
      "org.mozilla.firefox"
      "md.obsidian.Obsidian"
      "com.spotify.Client"
      "io.github.CyberTimon.RapidRAW"
      "org.freedownloadmanager.Manager"
      "org.gnome.Loupe"
      "org.gnome.Loupe.HEIC"
      "org.gnome.Showtime"
      "org.gnome.FileRoller"
      "dev.zed.Zed"
      "com.valvesoftware.Steam"
      "io.github.Faugus.faugus-launcher"
    ];

    update = {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };

    overrides = {
      global = {
        Environment = {
          TZ = timeZone;
          XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
          GTK_IM_MODULE = "ibus";
          QT_IM_MODULE = "ibus";
          XMODIFIERS = "@im=ibus";
        };

        Context = {
          filesystems = [
            "/usr/share/icons:ro"
            "~/.icons:ro"
            "~/.local/share/icons:ro"
            "~/.config/gtk-3.0:ro"
            "~/.config/gtk-4.0:ro"
            "xdg-config/gtk-3.0:ro"
            "xdg-config/gtk-4.0:ro"
            "/mnt"
            "/media"
            "/run/media"
          ];
        };
      };

      "dev.zed.Zed" = {
        Environment = {
          ZED_FLATPAK_NO_ESCAPE = "1";
        };
        Context = {
          filesystems = [
            "host"
            "xdg-config/git:ro"
            "home/.gitconfig:ro"
            "xdg-config/gh"
            "~/.ssh:ro"
          ];
          sockets = [
            "talk-name=org.freedesktop.Flatpak"
            "ssh-auth"
            "secrets"
          ];
        };
      };

      "com.valvesoftware.Steam" = {
        Context = {
          filesystems = [
            "~/.var/app/io.github.Faugus.faugus-launcher/config/faugus-launcher/"
            "~/.config/faugus-launcher/"
          ];
          sockets = [
            "talk-name=org.freedesktop.Flatpak"
          ];
        };
      };

      "io.github.Faugus.faugus-launcher" = {
        Context = {
          filesystems = [
            "~/.var/app/com.valvesoftware.Steam/"
          ];
          sockets = [
            "talk-name=org.freedesktop.Flatpak"
          ];
        };
      };
    };
  };
}
