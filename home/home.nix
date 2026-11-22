{ pkgs, reel, ... }:
{
  imports = [ ./xdg.nix ];

  home = {
    stateVersion = "26.05";

    packages = with pkgs; [
      nixd
      nixfmt
      devenv
      xdg-ninja
      zed-editor
      opencode

      obsidian
      spotify
      rapidraw
      mission-center

      (callPackage "${reel}/package.nix" { })
    ];
  };

  programs = {
    bash.enable = true;

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
}
