{
  config,
  inputs,
  pkgs,
  lib,
  username,
  timeZone,
  ...
}:
{
  # Imports
  imports = [
    ../modules/host/desktop/niri.nix
    ../modules/host/programs/nix-ld.nix
    ../modules/host/programs/flatpak.nix
  ];

  # Boot
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernel = {
      sysctl = {
        "vm.swappiness" = 10;
      };
    };
    extraModprobeConfig = ''
      options snd_hda_intel power_save=0 power_save_controller=N
    '';
    kernelParams = [ "video=HDMI-A-2:1920x1080@70" ];
  };

  # Zram
  zramSwap.enable = true;

  # Nix & Nixpkgs
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  # Localization & Console
  time.timeZone = timeZone;
  i18n.defaultLocale = "es_MX.UTF-8";
  console.keyMap = "es";

  # Networking
  networking = {
    hostName = "nixos";
    nameservers = [ "127.0.0.1" ];
    networkmanager = {
      enable = true;
      dns = "none";
      wifi.powersave = false;
    };
  };

  # Users
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  # Environment
  environment = {
    systemPackages = with pkgs; [
      docker-compose
      ffmpegthumbnailer
    ];
    pathsToLink = [ "share/thumbnailers" ];
  };

  # Programs
  programs = {
    ssh.enableAskPassword = false;
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "-k 5";
      };
      flake = "/home/${username}/.config/nixos";
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  # Services
  services = {
    xserver = {
      enable = true;
      excludePackages = with pkgs; [ xterm ];
      xkb = {
        layout = "es";
        variant = "";
      };
    };
    dnsmasq = {
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
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    pulseaudio.enable = false;
    printing.enable = false;
    lact.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };

  # Hardware
  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    amdgpu.overdrive.enable = true;
  };

  # Security & Virtualization
  security.rtkit.enable = true;
  virtualisation.docker.enable = true;

  # State
  system.stateVersion = "25.11";
}
