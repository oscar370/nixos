{
  config,
  pkgs,
  ...
}: {
  # Imports
  imports = [
    ./hardware-configuration.nix
  ];

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Localization
  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "es_MX.UTF-8";

  # Console / keyboard
  console.keyMap = "es";
  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  # Users
  users.users.oscar = {
    isNormalUser = true;
    description = "Oscar";
    extraGroups = ["networkmanager" "wheel"];
  };

  # Nix
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Desktop / X11
  services.xserver.enable = true;

  # GNOME
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Remove GNOME apps
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-contacts
    gnome-clocks
    gnome-weather
    gnome-maps
    snapshot
    simple-scan
    gnome-characters
    gnome-connections
    gnome-font-viewer
    decibels
    baobab
    gnome-system-monitor
    geary
    gnome-calendar
    gnome-music
    epiphany
    seahorse
  ];

  # Remove XTerm
  services.xserver.excludePackages = with pkgs; [xterm];

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Hardware
  hardware.bluetooth.enable = true;

  # Programs
  programs.appimage.enable = true;

  programs.cloudflare-warp.enable = true;

  programs.podman.enable = true;

  programs.protontricks.enable = true;

  programs.mission-center.enable = true;

  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  #Services
  services.printing.enable = false;
  services.syncthing.enable = true;
  services.cloudflare-warp.enable = true;

  # Virtualization
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;

  # State
  system.stateVersion = "25.05";
}
