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
      "com.stremio.Stremio"
      "com.spotify.Client"
      "io.github.CyberTimon.RapidRAW"
      "org.freedownloadmanager.Manager"
      "org.gnome.Loupe"
      "org.gnome.Loupe.HEIC"
      "org.gnome.Showtime"
      "org.gnome.FileRoller"
      "dev.zed.Zed"
      "com.valvesoftware.Steam"
      "com.valvesoftware.Steam.CompatibilityTool.Proton-GE"
    ];

    update = {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "weekly";
      };
    };

    overrides = {
      global = {
        Environment = {
          TZ = timeZone;
          XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
          GTK_THEME = "Adwaita:dark";
          GTK_IM_MODULE = "ibus";
          QT_IM_MODULE = "ibus";
          XMODIFIERS = "@im=ibus";
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
    };
  };
}
