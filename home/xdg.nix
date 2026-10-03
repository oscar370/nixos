{ config, ... }:
let
  inherit (config.home) homeDirectory;
  inherit (config.xdg)
    configHome
    dataHome
    stateHome
    cacheHome
    ;

  # Suggested by xdg-ninja
  xdgVariables = {
    CARGO_HOME = "${dataHome}/cargo";
    RUSTUP_HOME = "${dataHome}/rustup";
    DOTNET_CLI_HOME = "${dataHome}/dotnet";
    DOCKER_CONFIG = "${configHome}/docker";
    NPM_CONFIG_CACHE = "${cacheHome}/npm";
    NODE_REPL_HISTORY = "${stateHome}/node_repl_history";
    PYTHON_HISTORY = "${stateHome}/python_history";
  };
in
{
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${homeDirectory}/Escritorio";
      documents = "${homeDirectory}/Documentos";
      download = "${homeDirectory}/Descargas";
      music = "${homeDirectory}/Música";
      pictures = "${homeDirectory}/Imágenes";
      videos = "${homeDirectory}/Vídeos";
      templates = "${homeDirectory}/Plantillas";
      publicShare = "${homeDirectory}/Público";
    };
  };

  # Home Manager modules use ~/.config instead of dotfiles when they can
  home.preferXdgDirectories = true;

  # ~/.gtkrc-2.0 -> ~/.config/gtk-2.0/gtkrc
  gtk.gtk2.configLocation = "${configHome}/gtk-2.0/gtkrc";

  # Terminals (bash) and GUI apps started from GNOME
  home.sessionVariables = xdgVariables;
  systemd.user.sessionVariables = xdgVariables;
}
