# yggdrasil's NixOS Config

This folder contains the full configuration for this NixOS system.

## Quick start

```sh
# Rebuild and switch to new config (after editing)
just upgrade yggdrasil

# Or manually:
sudo nixos-rebuild switch --flake .#yggdrasil
```

## Structure

```
~/nixo/
├── flake.nix               # Entry point — lists all inputs (dependencies)
├── flake.lock              # Auto-generated, pins input versions
├── justfile                # Shortcut commands (run with `just <command>`)
│
├── hosts/                  # Machine-specific configs
│   ├── yggdrasil.nix         # THIS MACHINE — main config for this laptop/desktop
│   └── hardware-config*.nix  # Auto-generated, don't edit
│
├── configs/                # App config files (niri, alacritty, ribbon, etc.)
│   ├── niri/config.kdl     # Window manager config
│   ├── alacritty/          # Terminal config
│   ├── ribbon/             # Status bar config
│   └── ...
│
├── modules/                # Reusable NixOS settings (imported automatically)
│   ├── desktop/            # Desktop environment
│   ├── hardware/           # Graphics, sound, power
│   ├── programs/           # App-specific Nix config (steam, fish, git, etc.)
│   ├── services/           # System services (ssh, flatpak, etc.)
│   ├── system/             # Core system settings (boot, network, nix, etc.)
│   ├── security/           # Hardening, polkit, doas
│   ├── home/               # User packages & dotfiles
│   └── users/              # User accounts
│
├── pkgs/                   # Custom packages (built from source)
├── overlays/               # Package modifications
├── themes/                 # GTK themes
```

### Where to edit

| What you want to do | File to edit |
|---|---|
| Change hostname, user, bootloader | `hosts/yggdrasil.nix` |
| Install a system package | `modules/home/packages.nix` |
| Change keyboard layout / locale | `modules/system/locale.nix` |
| Change window manager keybinds | `configs/niri/config.kdl` |
| Add a new app config | `configs/<app>/` + `modules/home/dotfiles.nix` |
| Change flake inputs (add a dependency) | `flake.nix` |

### Useful commands

```sh
just upgrade yggdrasil   # Rebuild system with changes
just flakeupd          # Update all flake inputs
just check            # Check config for errors
just gc               # Clean up old builds (free space)
```

## NixOS basics

- **Flakes** are the modern way to manage NixOS configs
- After editing any `.nix` file, run `just upgrade yggdrasil` to apply
- `hardware-configuration.nix` is auto-generated — don't edit it
- `modules/default.nix` auto-imports everything under `modules/`
