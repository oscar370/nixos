{
  config,
  pkgs,
  username,
  lib,
  ...
}:
{
  imports = [
    ./gnome.nix
    ./xdg.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "26.05";

    packages = with pkgs; [
      nixd
      nixfmt
      devenv
      xdg-ninja
      vscodium

      obsidian
      spotifast
      rapidraw
      mission-center
    ];
  };

  programs = {
    bash = {
      enable = true;
      historyFile = "${config.xdg.stateHome}/bash/history";
      shellAliases.adb = ''HOME="${config.xdg.dataHome}/android" adb'';
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

  # Bash doesn't create the history directory by itself
  home.activation.bashHistoryDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p "${config.xdg.stateHome}/bash"
  '';

  services = {
    syncthing.enable = true;
    easyeffects.enable = true;
  };
}
