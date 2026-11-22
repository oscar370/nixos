{
  pkgs,
  lib,
  reel,
  ...
}:
{
  imports = [ ./xdg.nix ];

  home = {
    packages = with pkgs; [
      nixd
      nixfmt
      devenv
      xdg-ninja

      obsidian
      spotify
      rapidraw
      mission-center

      (callPackage "${reel}/package.nix" { })
    ];

    # Home Manager always links ~/.mozilla/native-messaging-hosts (with a .keep file),
    # even when no native messaging hosts are set. The profile already lives in
    # $XDG_CONFIG_HOME/mozilla, and Firefox only reads native messaging manifests
    # from ~/.mozilla (https://bugzilla.mozilla.org/show_bug.cgi?id=2005167).
    # Drop this override if an extension needs a native host (KeePassXC, GSConnect...).
    file.".mozilla/native-messaging-hosts".enable = lib.mkForce false;
  };

  programs = {
    bash.enable = true;
    zed-editor.enable = true;
    opencode.enable = true;

    firefox = {
      enable = true;
      profiles.default = {
        id = 0;
        isDefault = true;
      };
    };

    git = {
      enable = true;
      settings.user = {
        name = "oscar370";
        email = "57201580+oscar370@users.noreply.github.com";
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };

  services = {
    syncthing.enable = true;
    easyeffects.enable = true;
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "lavender";
    firefox.force = true;
  };

  home.stateVersion = "26.05";
}
