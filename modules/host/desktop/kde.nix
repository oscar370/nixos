{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    unrar
    vlc
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    discover
  ];

  services = {
    desktopManager.plasma6.enable = true;

    # Default display manager for Plasma
    displayManager.plasma-login-manager.enable = true;

    # Optionally enable xserver
    # xserver.enable = true;
  };
}
