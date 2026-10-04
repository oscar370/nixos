{ pkgs, ... }:
{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      gnome-tweaks
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
