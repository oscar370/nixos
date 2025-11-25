## Instructions

Clone the repository where you have permissions (e.g.: `~/.config/nixos`).

```bash
git clone https://github.com/oscar370/nixos.git
```

Copy your `hardware-configuration.nix` using the script.

```bash
chmod +x ./setupHardwareConfig.sh

./setupHardwareConfig.sh
```

Now configure the files to your liking.

- In `flake.nix` you can modify the architecture and username.
- In `home/home.nix` you can replace the **user configuration**, home path, git configuration, user-level packages, and GNOME configuration.
- In `nix/configuration.nix` you will find system settings such as time zone, keyboard layout, enabling services, **configuring the user**, and more. Use the `configuration.nix` created by your system as a reference if you don't know what to configure.

Now compile the flake.

```bash
sudo nixos-rebuild switch --flake .#nixos
```

## What this flake includes

> Compared to the default Nix configuration with GNOME.

**At the system level:**

- Git
- Flatpak and GNOME Software
- Steam
- Firefox
- Bluetooth enabled
- AppImages support
- Printer support disabled
- Syncthing
- Cloudflare Warp
- Virtualization with Podman enabled
- xTerm removed.
- Extra GNOME packages uninstalled, except for tools considered essential (image and video viewer, gnome disk, gnome console, gnome text editor, etc.). Check `configuration.nix` to see the list of packages to be removed.

**At the user level:**

- Nixd and Alejandra for autocompletion and formatting in `nix` files in IDEs
- VS Code
- PaperWM (extension)
- AppIndicator (extension)
- Initial DE settings were modified, such as dark mode enabled, shortcuts, and settings for PaperWM.

**Aliases are also built for bash:**

NixOS rebuild with flake
`nr`

Build only the system
`nrbuild `

Rebuild and reboot with boot
`nrboot`

Update flake.lock and rebuild
`nrfu”;`

Clean up old generations
`nrclean`

Show available generations
`nrgens`
