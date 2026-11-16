{
  lib,
  pkgs,
  paperwm-src,
  ...
}:
let
  cursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  # nixpkgs' gnomeExtensions.paperwm doesn't support GNOME 51 yet
  paperwm = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "paperwm";
    version = "git";
    src = paperwm-src;

    nativeBuildInputs = [ pkgs.glib ];

    installPhase = ''
      runHook preInstall
      dest=$out/share/gnome-shell/extensions/${finalAttrs.passthru.extensionUuid}
      mkdir -p $dest
      cp -r . $dest
      glib-compile-schemas $dest/schemas
      runHook postInstall
    '';

    passthru.extensionUuid = "paperwm@paperwm.github.com";
  });

in
{
  home.packages = with pkgs; [
    morewaita-icon-theme
    gnome-tweaks
  ];

  home.pointerCursor = cursor // {
    enable = true;
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
    extensions = with pkgs; [
      { package = gnomeExtensions.appindicator; }
      { package = paperwm; }
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

    # Wait longer before the "not responding" dialog (shader compilation, ENB…)
    "org/gnome/mutter" = {
      check-alive-timeout = lib.hm.gvariant.mkUint32 30000;
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
      take-window = [ "" ];
    };
  };
}
