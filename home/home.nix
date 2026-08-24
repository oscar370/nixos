{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Imports
  imports = [
    ../modules/home/desktop/caelestia.nix
  ];

  # Replace
  home.username = "oscar";
  home.homeDirectory = "/home/oscar";

  # User Packages
  home.packages = with pkgs; [
    nil
    nixd
    nixfmt
    devenv
  ];

  # Programs
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "oscar370";
        email = "57201580+oscar370@users.noreply.github.com";
      };
    };
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };

  # Services
  services.syncthing = {
    enable = true;
  };

  home.stateVersion = "25.11";
}
