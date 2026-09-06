{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Services & Desktop Environment
  services = {
    xserver = {
      desktopManager.cinnamon.enable = true;
      displayManager.lightdm.enable = true;
    };

    gnome.gnome-online-accounts.enable = true;
  };

  # Environment Variables
  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1"; # Fix Firefox-based browsers scroll on X11.
  };
}
