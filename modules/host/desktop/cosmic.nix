{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf (config.desktop == "cosmic") {
  # Cosmic
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  services.system76-scheduler.enable = true;
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
}
lib.mkIf (config.programs.firefox.enable && config.desktop == "cosmic") {
  programs.firefox.preferences = {
    "widget.gtk.libadwaita-colors.enabled" = false;
  };
}
