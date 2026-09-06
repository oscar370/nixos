{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs = {
    niri.enable = true;
    dconf.enable = true;
  };

  security.polkit.enable = true;

  services = {
    displayManager.gdm.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";

    systemPackages = with pkgs; [
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
  };
}
