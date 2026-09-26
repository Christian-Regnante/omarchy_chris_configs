# Catppuccin Neovim Configuration Dotfiles

Personal Neovim setup built for performance and aesthetics.

## Features

- **Theme**: [Catppuccin](https://github.com/catppuccin/nvim) (Mocha flavour)
- **Plugin Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Statusline**: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) (Catppuccin theme)
- **Syntax Highlighting**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

## Directory Structure

```
.
├── init.lua             # Config entry point
├── lazy-lock.json       # Plugin lockfile
└── lua/
    ├── config/
    │   ├── keymaps.lua  # Keybindings & leader key
    │   ├── lazy.lua     # Lazy.nvim bootstrap & setup
    │   └── options.lua  # Editor options & UI settings
    └── plugins/
        ├── catppuccin.lua
        ├── lualine.lua
        └── treesitter.lua
```

## How to Install on a New Machine

1. Ensure Neovim (v0.8+) and `git` are installed.
2. Clone this repository directly into `~/.config/nvim`:
   ```bash
   git clone <YOUR-GITHUB-REPO-URL> ~/.config/nvim
   ```
3. Start Neovim:
   ```bash
   nvim
   ```
   `lazy.nvim` will automatically download and install all plugins on first launch.

## Pushing to GitHub

To push these dotfiles to your GitHub account:

```bash
cd ~/neovim_configs
git remote add origin git@github.com:YOUR_USERNAME/YOUR_REPO_NAME.git
git branch -M main
git push -u origin main
```
