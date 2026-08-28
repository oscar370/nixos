{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:
let
  timeZone = "America/Mexico_City";
in
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
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Binary cache
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  # Desktop / X11
  services.xserver.enable = true;
  imports = [
    ../modules/host/programs/nix-ld.nix
    ../modules/host/desktop/niri.nix
    # ../modules/host/services/timers.nix
    # ../modules/host/kernel/cpuid-fault-emulation.nix
  ];

  # Remove XTerm
  services.xserver.excludePackages = with pkgs; [ xterm ];

  # Localization
  time.timeZone = timeZone;
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

  #DNS config
  networking.networkmanager.dns = "none";
  services.dnsmasq = {
    enable = true;
    settings = {
      server = [
        "1.1.1.1"
        "8.8.8.8"
      ];
      bogus-priv = true;
      domain-needed = true;
      cache-size = 1000;
    };
  };
  networking.nameservers = [ "127.0.0.1" ];

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
    ffmpegthumbnailer
  ];

  # Environment paths
  environment.pathsToLink = [
    "share/thumbnailers"
  ];

  # Programs
  programs.ssh.enableAskPassword = false;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "-k 5";
    flake = "/home/oscar/.config/nixos"; # Replace
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Services
  services.printing.enable = false;
  services.lact.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Flatpak
  services.flatpak.enable = true;
  services.flatpak.packages = [
    "io.github.kolunmi.Bazaar"
    "org.mozilla.firefox"
    "md.obsidian.Obsidian"
    "io.missioncenter.MissionCenter"
    "com.stremio.Stremio"
    "com.spotify.Client"
    "io.github.CyberTimon.RapidRAW"
    "com.valvesoftware.Steam"
    "com.valvesoftware.Steam.CompatibilityTool.Proton-GE"
  ];
  services.flatpak.update.onActivation = true;
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly"; # Default value
  };
  services.flatpak.overrides = {
    global = {
      Environment = {
        TZ = timeZone;
      };
    };
  };

  # Virtualization
  virtualisation.docker = {
    enable = true;
  };

  # Optimize Store
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "weekly" ];

  # State
  system.stateVersion = "25.11";
}
