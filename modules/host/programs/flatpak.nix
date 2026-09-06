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
        };
      };

      "dev.zed.Zed" = {
        Environment = {
          ZED_FLATPAK_NO_ESCAPE = "1";
        };
        Context = {
          filesystems = [
            "host"
            "~/.gitconfig:ro"
            "~/.config/git:ro"
            "~/.ssh:ro"
          ];
        };
        sockets = [
          "talk-name=org.freedesktop.Flatpak"
          "ssh-auth"
        ];
      };
    };
  };
}
