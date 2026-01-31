{
  config,
  pkgs,
  lib,
  ...
}: {
  # User Packages
  home.packages = with pkgs; [
    gnomeExtensions.paperwm
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
  ];

  # GNOME Configuration
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        paperwm.extensionUuid
        appindicator.extensionUuid
        user-themes.extensionUuid
      ];
    };

    "org/gnome/desktop/interface" = {
      accent-color = "teal";
      color-scheme = "prefer-dark";
    };

    #"org/gnome/desktop/peripherals/mouse" = {
    #  accel-profile = "flat";
    #};

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = ["<Shift><Super>s"];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      home = ["<Super>e"];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Open terminal";
      command = "kgx";
      binding = "<Super>t";
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      take-window = ["<Super>w"];
    };

    "org/gnome/shell/extensions/paperwm" = {
      disable-topbar-styling = true;
      show-focus-mode-icon = false;
      show-open-position-icon = false;
      show-window-position-bar = false;
      show-workspace-indicator = false;
    };
  };
}
