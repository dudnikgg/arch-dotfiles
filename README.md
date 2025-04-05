# Arch Linux Dotfiles

This repository contains my personal dotfiles for Arch Linux with Hyprland. These configuration files are designed to create a modern, efficient, and visually appealing desktop environment using Wayland.

## Overview

![Desktop Screenshot](https://placeholder-for-your-screenshot.png)

This dotfiles collection is built around:

- **Hyprland** - A dynamic tiling Wayland compositor
- **Waybar** - A highly customizable status bar
- **Zsh** - Shell with custom configurations and plugins
- **Dracula Theme** - A dark theme applied across various components

## Components

| Component | Description |
|-----------|-------------|
| `hypr/` | Hyprland compositor configuration |
| `waybar/` | Status bar with custom modules |
| `zshrc/` | Zsh shell configuration with Powerlevel10k |
| `keyd/` | Key remapping daemon configuration |
| `wofi/` | Application launcher for Wayland |
| `swaync/` | Notification center |
| `ghostty/` | Terminal emulator configuration |
| `nvim/` | Neovim configuration |
| `yazi/` | File manager configuration |
| `backgrounds/` | Wallpapers collection |
| `gtk-theme/` | GTK theme configuration |
| `icons/` | Icon themes |

## Installation

### Prerequisites

- Arch Linux (or Arch-based distribution)
- Hyprland
- Waybar
- Zsh
- Other components as needed (see below for full list)

### Dependencies

```bash
# Core components
yay -S hyprland waybar zsh wofi swaync ghostty

# Additional utilities
yay -S hyprpaper hypridle hyprlock eza fd bat rsync

# Optional components
yay -S neovim yazi
```

### Setup

1. Clone this repository:

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
```

2. Use GNU Stow (recommended) to create symlinks:

```bash
cd ~/dotfiles
stow hypr waybar zshrc # Add other directories as needed
```

Alternatively, manually copy or symlink the configuration files to their respective locations.

## Configuration Details

### Hyprland

The Hyprland configuration (`hypr/.config/hypr/hyprland.conf`) includes:

- Custom keybindings for window and workspace management
- Dracula theme integration
- Smooth animations
- Autostart applications
- Multi-monitor support

### Waybar

The Waybar configuration (`waybar/.config/waybar/config`) includes:

- System monitoring modules (CPU, memory, disk, temperature)
- Network and audio controls
- Workspace indicators
- Custom updates module
- Notification integration with swaync

### Zsh

The Zsh configuration includes:

- Powerlevel10k theme
- Custom aliases for git, file listing (using eza), and other utilities
- Functions for git branch creation and rsync operations
- Modular configuration with separate files for different aspects

### Keyd

The key remapping configuration (`keyd/etc/keyd/default.conf`) includes:

- Swapping Caps Lock and Escape
- Swapping Left Control and Left Alt

## Usage

### Key Bindings

| Binding | Action |
|---------|--------|
| `Super + Q` | Launch terminal |
| `Super + C` | Close active window |
| `Super + E` | Launch file manager |
| `Super + F` | Launch application launcher (wofi) |
| `Super + V` | Toggle floating mode |
| `Super + [1-0]` | Switch to workspace |
| `Super + Shift + [1-0]` | Move window to workspace |
| `Super + Arrow Keys` | Move focus |
| `Super + Alt + Arrow Keys` | Move window |
| `Super + Tab` | Switch to previous workspace |
| `Print` | Screenshot (region) |
| `Shift + Print` | Screenshot (window) |
| `Ctrl + Alt + Q` | Lock screen |

### Custom Aliases

```bash
# Git aliases
g           # git
gl          # git log with pretty format
gst         # git status
gs          # git switch
gc          # git commit
gph         # git push origin HEAD
gpl         # git pull origin current_branch

# File listing with eza
ls          # List files with icons
ll          # Long listing with git status
la          # List all files including hidden
lla         # Long listing of all files

# Other
rcp         # rsync copy with progress
rmv         # rsync move with progress
```

## Customization

### Changing Theme

The configurations use the Dracula color scheme. To change the theme:

1. Modify the color values in `hypr/.config/hypr/hyprland.conf`
2. Update the corresponding colors in Waybar and other components

### Adding/Removing Components

Each component is organized in its own directory, making it easy to add or remove components:

1. To add a new component, create a directory with the appropriate structure
2. To remove a component, simply don't stow that directory

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Hyprland](https://hyprland.org/)
- [Waybar](https://github.com/Alexays/Waybar)
- [Dracula Theme](https://draculatheme.com/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
