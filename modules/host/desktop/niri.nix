{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.niri.enable = true;
  programs.dconf.enable = true;

  security.polkit.enable = true;

  services.displayManager.gdm.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-console
    gnome-disk-utility
    gnome-calculator
    gnome-text-editor
    xwayland-satellite
    nautilus
    glib
    adwaita-icon-theme
    smartmontools
    dosfstools # FAT32 / vFAT
    ntfs3g # NTFS (Windows)
    e2fsprogs # ext4
    exfatprogs # exFAT
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
