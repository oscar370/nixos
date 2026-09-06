{
  config,
  lib,
  pkgs,
  ...
}:
{
  # GNOME
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Environment & Packages
  environment = {
    systemPackages = with pkgs; [
      gnome-tweaks
      morewaita-icon-theme
    ];

    # Remove GNOME default apps
    gnome.excludePackages = with pkgs; [
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
      gnome-software
      loupe
      showtime
    ];
  };
}
