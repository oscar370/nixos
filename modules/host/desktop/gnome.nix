{
  config,
  lib,
  pkgs,
  ...
}: {
  # GNOME
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Remove GNOME apps
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-contacts
    gnome-clocks
    gnome-weather
    gnome-maps
    snapshot
    simple-scan
    gnome-characters
    gnome-connections
    gnome-font-viewer
    decibels
    baobab
    gnome-system-monitor
    geary
    gnome-calendar
    gnome-music
    epiphany
    seahorse
  ];
}
