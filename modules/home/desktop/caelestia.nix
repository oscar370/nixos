{ pkgs, ... }:
{
  # Caelestia
  programs.caelestia = {
    enable = true;
    
    systemd.enable = true;

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
