{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.displayManager.gdm.enable = true;
  programs.niri.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-console
    alacritty
    xwayland-satellite
    nautilus
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
