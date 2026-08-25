{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.displayManager.gdm.enable = true;
  programs.niri.enable = true;

  programs.dconf.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-console
    xwayland-satellite
    nautilus
    glib
    adwaita-icon-theme
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
