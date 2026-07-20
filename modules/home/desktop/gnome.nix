{
  config,
  pkgs,
  lib,
  ...
}:
{
  # User Packages
  home.packages = with pkgs; [
    gnomeExtensions.paperwm
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    gnomeExtensions.dash-to-panel
  ];

  # GNOME Configuration
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        # paperwm.extensionUuid
        appindicator.extensionUuid
        user-themes.extensionUuid
        dash-to-panel.extensionUuid
      ];
    };

    "org/gnome/desktop/interface" = {
      accent-color = "teal";
      color-scheme = "prefer-dark";
      cursor-theme = "Adwaita";
      cursor-size = 24;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Shift><Super>s" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      home = [ "<Super>e" ];
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
      take-window = [ "<Super>w" ];
    };

    "org/gnome/shell/extensions/paperwm" = {
      disable-topbar-styling = true;
      show-focus-mode-icon = false;
      show-open-position-icon = false;
      show-window-position-bar = false;
      show-workspace-indicator = false;
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      appicon-margin = 0;
      dot-position = "BOTTOM";
      dot-style-focused = "METRO";
      dot-style-unfocused = "DOTS";
      panel-element-positions = ''
        {
          "0": [
            {"element": "showAppsButton", "visible": false, "position": "stackedTL"},
            {"element": "activitiesButton", "visible": true, "position": "stackedTL"},
            {"element": "leftBox", "visible": true, "position": "stackedTL"},
            {"element": "taskbar", "visible": true, "position": "centerMonitor"},
            {"element": "centerBox", "visible": true, "position": "stackedBR"},
            {"element": "rightBox", "visible": true, "position": "stackedBR"},
            {"element": "dateMenu", "visible": true, "position": "stackedBR"},
            {"element": "systemMenu", "visible": true, "position": "stackedBR"},
            {"element": "desktopButton", "visible": true, "position": "stackedBR"}
          ]
        }
      '';
      panel-positions = ''{"0": "TOP"}'';
      panel-sizes = ''{"0": 32}'';
      scroll-panel-action = "NOTHING";
    };
  };
}
