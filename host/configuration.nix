{ pkgs, username, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./gnome.nix
    ./shutdown.nix
  ];

  # Boot
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.page-cluster" = 0;
    };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Keep the HDA codec awake (avoids pops when audio starts)
    extraModprobeConfig = ''
      options snd_hda_intel power_save=0 power_save_controller=N
    '';
  };

  zramSwap.enable = true;

  # Nix
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      use-xdg-base-directories = true;
    };

    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  # Locale
  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "es_MX.UTF-8";
  console.useXkbConfig = true;

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

  # Programs
  programs = {
    firefox.enable = true;
    steam.enable = true;
    nix-ld.enable = true;
    ssh.enableAskPassword = false;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    nh = {
      enable = true;
      flake = "/home/${username}/.config/nixos";
      clean = {
        enable = true;
        extraArgs = "--keep 3";
      };
    };
  };

  # Services
  services = {
    xserver.xkb.layout = "es";

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    pulseaudio.enable = false;

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

    lact.enable = true;
    languagetool.enable = true;
  };

  # Video thumbnails in Nautilus
  environment = {
    systemPackages = [ pkgs.ffmpegthumbnailer ];
    pathsToLink = [ "share/thumbnailers" ];
  };

  # Hardware
  hardware = {
    bluetooth.enable = true;
    amdgpu.overdrive.enable = true; # required by LACT
  };

  security.rtkit.enable = true;
  virtualisation.docker.enable = true;

  system.stateVersion = "26.05";
}
