# dotfiles

Personal configuration files for zsh, Neovim, WezTerm, Starship, and tmux.

## Quick start

```sh
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

The script is idempotent — safe to run multiple times. Existing files are backed up with a `.bak` suffix before being replaced by symlinks.

## What gets installed

### Shell
| Tool | Purpose |
|------|---------|
| zsh | Shell |
| Oh My Zsh | Plugin framework |
| starship | Cross-shell prompt |
| fzf | Fuzzy finder (Ctrl+R, Ctrl+T, `**` completion) |
| eza | Modern `ls` with icons and git status |
| bat | Syntax-highlighted `cat` |
| zoxide | Smarter `cd` (aliased to `z`) |
| fd | Fast `find` replacement |
| ag | Fast grep replacement (The Silver Searcher) |
| fastfetch | System info on shell startup |

### Oh My Zsh plugins
| Plugin | Purpose |
|--------|---------|
| fzf-tab | fzf-powered tab completion |
| zsh-autosuggestions | Fish-style inline suggestions |
| fast-syntax-highlighting | Command syntax highlighting |
| zsh-completions | Extra completion definitions |

## Symlinks created

| Symlink | Source |
|---------|--------|
| `~/.zshrc` | `zsh/.zshrc` |
| `~/.zshenv` | `zsh/.zshenv` |
| `~/.config/starship.toml` | `starship/starship.toml` |
| `~/.config/nvim` | `nvim/` |
| `~/.config/wezterm` | `wezterm/` |
| `~/.tmux.conf` | `.tmux.conf` |

## Repository structure

```
dotfiles/
├── install.sh               bootstrap script
├── zsh/
│   ├── .zshrc               main zsh config (Oh My Zsh, aliases, functions)
│   └── .zshenv              minimal env vars sourced for all zsh instances
├── starship/
│   └── starship.toml        prompt config
├── nvim/                    Neovim config (lazy.nvim, LSP, Treesitter)
│   └── SETUP.md             Neovim-specific setup and keybinding reference
├── wezterm/
│   └── wezterm.lua          terminal emulator config
├── bash/                    legacy bash config (not actively used)
└── .tmux.conf               tmux config
```

## Neovim

See [nvim/SETUP.md](nvim/SETUP.md) for the full setup guide, plugin list, and keybinding reference.

Neovim requires some additional tools not installed by `install.sh`:

```sh
# Node (required by many LSP servers)
# Install via nvm: https://github.com/nvm-sh/nvm
nvm install --lts

# Node-based formatters
npm install -g @fsouza/prettierd

# Python formatter
pip3 install black
```

On first launch, lazy.nvim will auto-install all plugins. Then run `:Mason` to install LSP servers.

## macOS notes

On macOS, Homebrew is used for all tools. If Homebrew is not installed, the script installs it automatically.

## Linux notes

Most tools install via `apt`. Tools unavailable in apt (fzf, eza, zoxide, fastfetch) are installed from their official release channels.

`fzf` is cloned into `~/fzf` so it can be updated with:
```sh
git -C ~/fzf pull && ~/fzf/install --bin
```
