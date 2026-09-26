#!/usr/bin/env bash
# ==============================================================================
# Omarchy Custom Configurations Installer
# ==============================================================================
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

echo "=========================================================="
echo "   Installing Omarchy Custom Dotfiles"
echo "   Source: ${DOTFILES_DIR}"
echo "   Target: ${TARGET_CONFIG_DIR}"
echo "=========================================================="
echo ""

# Ensure target config and icons directory exist
mkdir -p "${TARGET_CONFIG_DIR}"
mkdir -p "$HOME/.icons/default"

# 1. Check for Catppuccin cursors package from AUR
if [ ! -d "/usr/share/icons/catppuccin-mocha-dark-cursors" ]; then
    echo "-> catppuccin-cursors-mocha not found in /usr/share/icons/."
    if command -v omarchy &>/dev/null; then
        echo "   Installing catppuccin-cursors-mocha via Omarchy..."
        omarchy pkg aur add catppuccin-cursors-mocha || true
    elif command -v yay &>/dev/null; then
        echo "   Installing catppuccin-cursors-mocha via yay..."
        yay -S --noconfirm catppuccin-cursors-mocha || true
    else
        echo "   [NOTE] Please install 'catppuccin-cursors-mocha' from AUR manually."
    fi
fi

# 2. Deploy .icons/default/index.theme
if [ -f "${DOTFILES_DIR}/.icons/default/index.theme" ]; then
    cp "${DOTFILES_DIR}/.icons/default/index.theme" "$HOME/.icons/default/index.theme"
    echo "  [OK] Installed ~/.icons/default/index.theme"
fi

# 3. List of files/directories to deploy from .config/
CONFIG_ITEMS=(
    "starship.toml"
    "ghostty/config"
    "kitty/kitty.conf"
    "alacritty/alacritty.toml"
    "hypr/autostart.lua"
    "hypr/bindings.lua"
    "hypr/hyprland.lua"
    "hypr/input.lua"
    "hypr/looknfeel.lua"
    "hypr/monitors.lua"
    "hypr/hyprsunset.conf"
    "hypr/xdph.conf"
    "omarchy/shell.json"
    "omarchy/shell.toml"
)

echo ""
echo "-> Backing up existing files and deploying new configs..."
for item in "${CONFIG_ITEMS[@]}"; do
    src="${DOTFILES_DIR}/.config/${item}"
    dest="${TARGET_CONFIG_DIR}/${item}"

    if [ ! -f "${src}" ]; then
        echo "  [SKIP] Source not found: ${src}"
        continue
    fi

    # Ensure destination parent directory exists
    mkdir -p "$(dirname "${dest}")"

    # Backup if destination exists and differs
    if [ -f "${dest}" ]; then
        if cmp -s "${src}" "${dest}"; then
            echo "  [SAME] ${item} is already up to date."
            continue
        else
            backup_path="${dest}.bak.${TIMESTAMP}"
            cp "${dest}" "${backup_path}"
            echo "  [BACKUP] Saved existing ${item} to ${backup_path}"
        fi
    fi

    # Copy new config file
    cp "${src}" "${dest}"
    echo "  [OK] Installed ${item}"
done

echo ""
echo "-> Applying changes to active session..."

# Set GTK and Hyprland cursor themes
if command -v gsettings &>/dev/null; then
    gsettings set org.gnome.desktop.interface cursor-theme "catppuccin-mocha-dark-cursors" 2>/dev/null || true
    gsettings set org.gnome.desktop.interface cursor-size 24 2>/dev/null || true
    echo "  [OK] Applied GTK cursor theme (catppuccin-mocha-dark-cursors)"
fi

if command -v hyprctl &>/dev/null; then
    hyprctl setcursor catppuccin-mocha-dark-cursors 24 2>/dev/null || true
    echo "  [OK] Applied Hyprland cursor theme"
fi

# Restart terminal if running inside Omarchy
if command -v omarchy &>/dev/null; then
    omarchy restart terminal 2>/dev/null || true
    echo "  [OK] Reloaded terminal settings with 'omarchy restart terminal'"
fi

echo ""
echo "=========================================================="
echo " Installation complete!"
echo " All terminal, cursor, and desktop configs applied."
echo "=========================================================="
