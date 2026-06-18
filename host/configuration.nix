{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
{
  # Boot
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0 power_save_controller=N
  '';
  boot.kernelParams = [
    "video=HDMI-A-2:1920x1080@70"
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
    ../modules/host/desktop/gnome.nix
    ../modules/host/programs/nix-ld.nix
    # ../modules/host/desktop/cosmic.nix
    # ../modules/host/desktop/cinnamon.nix
    # ../modules/host/services/timers.nix
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
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  # Enable overclocking on AMD
  hardware.amdgpu.overdrive.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    docker-compose
    direnv
    ffmpegthumbnailer
    lsfg-vk-ui
  ];

  # Thumbnailer
  environment.pathsToLink = [
    "share/thumbnailers"
  ];

  # Programs
  programs.ssh.enableAskPassword = false;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 5";
    flake = "/home/oscar/.config/nixos"; # Replace
  };
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraPackages = with pkgs; [
      lsfg-vk
    ];
  };

  # Services
  services.printing.enable = false;
  services.lact.enable = true;

  # Virtualization
  virtualisation.docker = {
    enable = true;
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
  system.stateVersion = "25.11";
}
