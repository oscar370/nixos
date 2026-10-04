{ lib, pkgs, ... }:
let
  cursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };
in
{
  home.packages = [ pkgs.morewaita-icon-theme ];

  home.pointerCursor = cursor // {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    dotIcons.enable = false;
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  # Installs and enables the extensions
  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = paperwm; }
      { package = appindicator; }
      { package = user-themes; }
      { package = dash-to-panel; }
    ];
  };

  dconf.settings = {
    # Appearance
    "org/gnome/desktop/interface" = {
      accent-color = "teal";
      color-scheme = "prefer-dark";
      icon-theme = "MoreWaita";
      cursor-theme = cursor.name;
      cursor-size = cursor.size;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    # Never sleep or dim
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      idle-dim = false;
    };

    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 0;
    };

    # Keybindings
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

    # PaperWM
    "org/gnome/shell/extensions/paperwm" = {
      disable-topbar-styling = true;
      show-focus-mode-icon = false;
      show-open-position-icon = false;
      show-window-position-bar = false;
      show-workspace-indicator = false;
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      take-window = [ "<Super>w" ];
    };

    # Dash to Panel
    "org/gnome/shell/extensions/dash-to-panel" = {
      appicon-margin = 0;
      dot-position = "BOTTOM";
      dot-style-focused = "METRO";
      dot-style-unfocused = "DOTS";
      scroll-panel-action = "NOTHING";
      panel-positions = builtins.toJSON { "0" = "TOP"; };
      panel-sizes = builtins.toJSON { "0" = 32; };
      panel-element-positions = builtins.toJSON {
        "0" = [
          {
            element = "showAppsButton";
            visible = false;
            position = "stackedTL";
          }
          {
            element = "activitiesButton";
            visible = true;
            position = "stackedTL";
          }
          {
            element = "leftBox";
            visible = true;
            position = "stackedTL";
          }
          {
            element = "taskbar";
            visible = true;
            position = "centerMonitor";
          }
          {
            element = "centerBox";
            visible = true;
            position = "stackedBR";
          }
          {
            element = "rightBox";
            visible = true;
            position = "stackedBR";
          }
          {
            element = "dateMenu";
            visible = true;
            position = "stackedBR";
          }
          {
            element = "systemMenu";
            visible = true;
            position = "stackedBR";
          }
          {
            element = "desktopButton";
            visible = true;
            position = "stackedBR";
          }
        ];
      };
    };
  };
}
