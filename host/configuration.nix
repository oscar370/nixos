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
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0 power_save_controller=N
  '';

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
    # ../modules/host/services/timers.nix
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
  services.pipewire.wireplumber.extraConfig."10-disable-suspend" = {
    "monitor.alsa.rules" = [
      {
        matches = [
          { "node.name" = "~alsa_output.*"; }
          { "node.name" = "~alsa_input.*"; }
        ];
        actions = {
          update-props = {
            "session.suspend-on-idle" = false;
          };
        };
      }
    ];
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
  ];

  # Programs
  programs.ssh.enableAskPassword = false;
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

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

  # Flatpaks
  services.flatpak.enable = true;
  services.flatpak.packages = [
    "io.github.kolunmi.Bazaar"
    "md.obsidian.Obsidian"
    "org.mozilla.firefox"
    "io.missioncenter.MissionCenter"
    "com.github.Matoking.protontricks"
    "com.vysp3r.ProtonPlus"
  ];
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly"; # Default value
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
