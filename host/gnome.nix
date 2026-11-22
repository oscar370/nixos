{ pkgs, ... }:
{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment = {
    # Codecs for Nautilus properties and GNOME media apps (H.264/H.265, AAC…)
    systemPackages = with pkgs; [
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-plugins-ugly
      gst_all_1.gst-libav
      ffmpegthumbnailer
    ];

    gnome.excludePackages = with pkgs; [
      baobab
      decibels
      epiphany
      geary
      gnome-calendar
      gnome-characters
      gnome-clocks
      gnome-connections
      gnome-contacts
      gnome-font-viewer
      gnome-maps
      gnome-music
      gnome-software
      gnome-system-monitor
      gnome-tour
      gnome-weather
      seahorse
      simple-scan
      snapshot
    ];
  };
}
