{
  config,
  pkgs,
  lib,
  ...
}:
{
  dconf.settings = {
    "org/cinnamon/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/cinnamon/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/cinnamon/settings-daemon/plugins/power" = {
      sleep-display-ac = 0;
      sleep-inactive-ac-type = "nothing";
      power-button-action = "nothing";
    };

    "org/cinnamon/desktop/screensaver" = {
      layout-group = 0;
      lock-enabled = false;
      lock-delay = 0;
    };

    "org/cinnamon/desktop/keybindings/wm" = {
      close = [ "<Super>q" ];
    };

    "org/cinnamon/desktop/keybindings/media-keys" = {
      area-screenshot = [ "<Shift><Super>s" ];
      home = [ "<Super>e" ];
    };

    "org/cinnamon/desktop/keybindings" = {
      custom-list = [ "custom0" ];
    };

    "org/cinnamon/desktop/keybindings/audio" = {
      sound-open = [ "@as []" ];
    };

    "org/cinnamon/desktop/keybindings/custom-keybindings/custom0" = {
      name = "Open terminal";
      command = "gnome-terminal";
      binding = [ "<Super>t" ];
    };
  };
}
