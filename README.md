# tmux Configuration

My personal tmux configuration.

## Prerequisites

- tmux ≥ 3.0
- zsh (configured as default shell)
- xclip (for clipboard integration)
- A Powerline-compatible font (for tmux-powerline status bar)

## Installation

### 1. Clone this repo

```bash
git clone git@github.com:gregfuenmayor/tmux-config.git ~/.config/tmux
```

> If you already have a `~/.config/tmux`, back it up first:
> `mv ~/.config/tmux ~/.config/tmux.bak`

### 2. Install TPM (Tmux Plugin Manager)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 3. Install plugins

Start tmux, then press `Ctrl-a + I` (capital I) to install all plugins automatically.

## Plugins

| Plugin | Description | Install method |
|--------|-------------|----------------|
| [tpm](https://github.com/tmux-plugins/tpm) | Plugin manager | Manual clone (step 2 above) |
| [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) | Sensible defaults | Via TPM |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | Save & restore sessions | Via TPM |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | Continuous session saving | Via TPM |
| [tmux-powerline](https://github.com/erikw/tmux-powerline) | Powerline status bar | Via TPM |

### tmux-powerline font setup

Install a Nerd Font or Powerline font and configure your terminal to use it.
On Arch/Manjaro:

```bash
sudo pacman -S ttf-nerd-fonts-symbols
# or
yay -S ttf-meslo-nerd-font-powerlevel10k
```

Then set that font in your terminal emulator's preferences.

## Key Bindings

| Key | Action |
|-----|--------|
| `Ctrl-a` | Prefix (replaces default `Ctrl-b`) |
| `Prefix + r` | Reload config |
| `Prefix + y` | Enter copy mode |
| `Prefix + L` | Switch to last window |
| `Prefix + h/j/k/l` | Navigate panes (vim-style) |
| `Prefix + I` | Install TPM plugins |

In copy mode (vi keys):
- `Enter` — copy selection to clipboard (xclip)
- Mouse drag — copy to clipboard
