## Instructions

### Install

- Clone the repository where you have permissions (e.g.: `~/.config/`). **Or fork this repository, and clone your fork if you want to stay in sync with GitHub.**

> If you choose a route other than `~/.config/`, modify the alias address in `home/home.nix`.

```bash
git clone https://github.com/oscar370/nixos.git
```

- Copy your `hardware-configuration.nix` using the script.

```bash
./setupHardwareConfig.sh
```

> If you change your hardware, you have to regenerate the file with `nixos-generate-config`. You can read more [here](https://wiki.nixos.org/wiki/Nixos-generate-config).

### Config

#### Entry point

In `flake.nix` you can modify the architecture and username. This is where the main modules are imported.

#### Home

In `home/home.nix` you can replace the **user configuration**, home path, git configuration, user-level packages, and GNOME configuration.

#### System

In `host/configuration.nix` you will find system settings such as time zone, keyboard layout, enabling services, **configuring the user**, and more.

> Use the `configuration.nix` created by your system as a reference if you don't know what to configure.

#### Modules

In `modules/`, you will find the nix files that you can import as you prefer. For example, in `modules/host/desktop` there are the configurations for each DE.

In `configuration.nix`, you will have to remove the lines for the DEs you do not want to install and add those you do want to install.

The same applies to user modules, except that the entry points are located in `home.nix`.

### Compiling

Now compile the flake.

```bash
sudo nixos-rebuild switch --flake ~/.config/nixos
```

## What this flake includes

> Compared to the default Nix configuration with GNOME.

**At the system level:**

- Zen kernel
- Custom resolution in kernel params
  > **Remove or modify this in `configuration.nix`, the resolution may be incompatible with your system, or it may point to the wrong video adapter on your system**
- Zram
- Git
- Flatpak and GNOME Software
- Steam
- Firefox
- Bluetooth enabled
- AppImages support
- Nix-ld with the list provided [here](https://wiki.nixos.org/wiki/Nix-ld).
- Printer support disabled
- Syncthing
- Virtualization with Podman enabled
- xTerm removed
- Automatic garbage disposal every 30 days
- Extra GNOME packages uninstalled, except for tools considered essential (image and video viewer, gnome disk, gnome console, gnome text editor, etc.). Check `configuration.nix` to see the list of packages to be removed
- Extra module with Cosmic DE, _disabled by default_. You can use it as a reference to add more modules.

**At the user level:**

- Nixd and Alejandra for autocompletion and formatting in `nix` files in IDEs
- VS Code
- PaperWM (extension)
- AppIndicator (extension)
- Initial DE settings were modified, such as dark mode enabled, shortcuts, and settings for PaperWM
- Extra module for Cosmic DE, _disabled by default_. You can use it as a reference to add more modules.

**Aliases are also built for bash:**

- NixOS rebuild with flake: `nr`
- Build only the system: `nrbuild `
- Rebuild and reboot with boot: `nrboot`
- Update flake.lock and rebuild: `nrfu`
- Clean up old generations: `nrclean` _It will delete all except the current one_
- Show available generations: `nrgens`
