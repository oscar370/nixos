{
  config,
  inputs,
  pkgs,
  ...
}:
{
  # Boot
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
  boot.kernelParams = [
    "video=HDMI-A-2:1920x1080@73"
  ];

  # Zram
  zramSwap.enable = true;

  # Nix
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Desktop / X11
  services.xserver.enable = true;
  imports = [
    # ../modules/host/desktop/cosmic.nix
    ../modules/host/desktop/gnome.nix
    ../modules/host/services/timers.nix
    ../modules/host/programs/nix-ld.nix
  ];

  # Remove XTerm
  services.xserver.excludePackages = with pkgs; [ xterm ];

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

  # DNS config
  networking.networkmanager.dns = "none";
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  # Users
  users.users.oscar = {
    isNormalUser = true;
    description = "Oscar";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

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
  # Enable overclocking on AMD
  hardware.amdgpu.overdrive.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  # Programs
  programs.ssh.enableAskPassword = false;
  programs.gamemode.enable = true;

  # Services
  services.printing.enable = false;
  services.lact.enable = true;
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "oscar";
    group = "users";
    configDir = "/home/oscar/.config/syncthing";
  };

  services.flatpak.enable = true;
  services.flatpak.packages = [
    "io.github.kolunmi.Bazaar"
    "md.obsidian.Obsidian"
    "org.mozilla.firefox"
    "com.valvesoftware.Steam"
    "io.missioncenter.MissionCenter"
    "com.github.Matoking.protontricks"
  ];
  services.flatpak.overrides = {
    global = {
      # Force Wayland by default
      Context.sockets = ["wayland" "!x11" "!fallback-x11"];

      Environment = {
        # Fix un-themed cursor in some Wayland apps
        XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
      };
    };
  };

  # Virtualization
  virtualisation.docker = {
    enable = true;
  };

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Optimize Store
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];

  # AppImages config
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # State
  system.stateVersion = "25.05";
}
