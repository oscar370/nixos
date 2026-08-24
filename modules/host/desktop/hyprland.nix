{ pkgs, ... }:
{
  # Habilitar Hyprland a nivel de sistema
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # SDDM Display Manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Portals para Wayland
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Electron en Wayland nativo
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = [ pkgs.kitty ];
}