{ config, ... }:
{
  services.flatpak = {
    enable = true;

    update = {
      onActivation = true;
      auto = {
        enable = true;
        onCalendar = "weekly";
      };
    };

    packages = [
      "com.valvesoftware.Steam"
      "com.github.Matoking.protontricks"
    ];

    overrides.global = {
      # The sandbox can't read NixOS's /etc/localtime symlink
      Environment = {
        TZ = config.time.timeZone;
        XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
      };

      Context.filesystems = [
        # Cursor and icon themes are symlinks into the Nix store
        "/nix/store:ro"
        "xdg-data/icons:ro"
      ];
    };
  };
}
