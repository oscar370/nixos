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
      sleep-inactive-ac-type = "nothing";
    };

    "org/cinnamon/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
    };

    "org/cinnamon/desktop/keybindings/media-keys" = {
      screenshot = [ "<Shift><Super>s" ];
      home = [ "<Super>e" ];
    };

    "org/cinnamon/desktop/keybindings" = {
      custom-list = [ "custom0" ];
    };

    "org/cinnamon/desktop/keybindings/custom-keybindings/custom0" = {
      name = "Open terminal";
      command = "gnome-terminal";
      binding = [ "<Super>t" ];
    };
  };
}
