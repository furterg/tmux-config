#!/usr/bin/env bash
# One-shot installer for https://github.com/furterg/tmux-config
#   curl -fsSL https://raw.githubusercontent.com/furterg/tmux-config/main/install.sh | bash
set -euo pipefail

REPO=https://github.com/furterg/tmux-config.git
CONF="${XDG_CONFIG_HOME:-$HOME/.config}/tmux"

say() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }
sudo_() { if [ "$(id -u)" -eq 0 ]; then "$@"; else sudo "$@"; fi; }

# --- platform detection: pick the package install command -------------------
case "$(uname -s)" in
  Darwin)
    have brew || { echo "Homebrew is required on macOS: https://brew.sh" >&2; exit 1; }
    pkg_install() { brew install "$@"; } ;;
  Linux)
    if   have apt-get; then pkg_install() { sudo_ apt-get update -qq && sudo_ apt-get install -y "$@"; }
    elif have pacman;  then pkg_install() { sudo_ pacman -S --needed --noconfirm "$@"; }
    elif have dnf;     then pkg_install() { sudo_ dnf install -y "$@"; }
    elif have zypper;  then pkg_install() { sudo_ zypper install -y "$@"; }
    elif have apk;     then pkg_install() { sudo_ apk add "$@"; }
    else echo "Unsupported Linux distribution (no known package manager)." >&2; exit 1; fi ;;
  *) echo "Unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

# --- dependencies ------------------------------------------------------------
missing=()
for tool in tmux git curl; do have "$tool" || missing+=("$tool"); done
if [ "${#missing[@]}" -gt 0 ]; then
  say "Installing: ${missing[*]}"
  pkg_install "${missing[@]}"
fi

# --- this repo ---------------------------------------------------------------
if [ -d "$CONF/.git" ]; then
  say "Updating $CONF"
  git -C "$CONF" pull --ff-only
else
  if [ -e "$CONF" ]; then
    say "Backing up existing $CONF to $CONF.bak"
    mv "$CONF" "$CONF.bak"
  fi
  say "Cloning config to $CONF"
  git clone "$REPO" "$CONF"
fi

# --- TPM + plugins -----------------------------------------------------------
[ -d "$CONF/plugins/tpm" ] || git clone --depth 1 https://github.com/tmux-plugins/tpm "$CONF/plugins/tpm"
say "Installing tmux plugins"
TMUX_PLUGIN_MANAGER_PATH="$CONF/plugins/" "$CONF/plugins/tpm/bin/install_plugins"

say "Done. Start tmux."
have qdbus || echo "Note: clipboard copy uses KDE Klipper via qdbus; copy-mode yanks won't reach the system clipboard without it." >&2
