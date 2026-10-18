{ pkgs, ... }:
{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Nautilus' wrapper only bundles basic GStreamer plugins; point every GNOME app
  # at the system ones so the audio/video properties can read MP4 (H.264/AAC)
  systemd.user.settings.Manager.DefaultEnvironment =
    "GST_PLUGIN_SYSTEM_PATH_1_0=/run/current-system/sw/lib/gstreamer-1.0";

  environment = {
    # Codecs for Nautilus properties and GNOME media apps (H.264/H.265, AAC…)
    systemPackages = with pkgs.gst_all_1; [
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
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
      loupe
    ];
  };
}
