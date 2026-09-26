# Omarchy Custom Configs & Dotfiles

Personal configuration files ("dotfiles") and desktop customizations for [Omarchy Linux](https://omarchy.org/) (Arch Linux + Hyprland).

---

## 🎨 Features Included

1. **Dynamic Typecraft-Style Terminal Prompt ([Starship](https://starship.rs/))**:
   - Multi-segment pastel powerline layout (`` pill, Arch logo `󰣇`, username, folder substitutions, Git status, dev runtimes, `` clock pill, `` arrow).
   - **Theme-Adaptive**: Uses terminal ANSI color roles so that switching themes with `omarchy theme set <theme>` automatically updates the prompt colors across all themes.

2. **Synchronized Terminal Emulators**:
   - **Ghostty**: JetBrainsMono Nerd Font (size 11), 90% opacity with background blur.
   - **Kitty**: Matched font size 11, 90% opacity with background blur.
   - **Alacritty**: Matched font size 11, 90% opacity with blur.

3. **Catppuccin Mocha Cursors**:
   - Native Hyprcursor and XCursor integration with `catppuccin-mocha-dark-cursors` (size 24).
   - Automatically configured across Hyprland, GTK apps, and legacy XWayland software.

4. **Desktop & Window Manager ([Hyprland](https://hypr.land/))**:
   - Window decorations (rounding = 8, inactive dimming).
   - Touchpad and input settings.
   - Custom keybindings and monitors configuration.

5. **Omarchy Shell**:
   - Custom status bar layout and widget positioning in `shell.json`.

---

## 📂 Repository Structure

```
omarchy_chris_configs/
├── .config/
│   ├── starship.toml          # Dynamic powerline shell prompt
│   ├── ghostty/config         # Ghostty styling & settings
│   ├── kitty/kitty.conf       # Kitty styling & settings
│   ├── alacritty/alacritty.toml # Alacritty styling & settings
│   ├── hypr/                  # Hyprland overrides (looknfeel, input, bindings, autostart)
│   └── omarchy/shell.json     # Status bar and widget configuration
├── .icons/
│   └── default/index.theme    # Legacy XWayland cursor fallback
├── install.sh                 # Deployment script (with automatic backups & AUR checks)
├── .gitignore                 # Excludes temporary & backup files
└── README.md                  # Documentation
```

---

## 🚀 How to Use on a New Laptop

Whenever you install Omarchy on your new laptop, simply:

1. **Clone your repository**:
   ```bash
   mkdir -p ~/Projects
   cd ~/Projects
   git clone https://github.com/<YOUR_GITHUB_USERNAME>/omarchy_chris_configs.git
   cd omarchy_chris_configs
   ```

2. **Run the installer**:
   ```bash
   ./install.sh
   ```

The script will automatically:
- Check for and install `catppuccin-cursors-mocha` from the AUR if missing.
- Back up any existing config files on the new machine before overwriting them.
- Copy your customized configs to `~/.config/` and `~/.icons/`.
- Apply your cursor themes (Hyprland + GTK).
- Run `omarchy restart terminal` so changes apply immediately.

---

## 📤 Pushing to GitHub

```bash
cd ~/Projects/omarchy_chris_configs
git add .
git commit -m "feat: add catppuccin mocha dark cursor theme"
git push
```
