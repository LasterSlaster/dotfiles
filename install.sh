#!/usr/bin/env bash
# install.sh — interactive dotfiles bootstrap
# Idempotent: safe to run multiple times.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname)"

# ── Colours ────────────────────────────────────────────────────────────────────
GRN='\033[0;32m'; YLW='\033[1;33m'; BLD='\033[1m'; DIM='\033[2m'; NC='\033[0m'
log()  { echo -e "${GRN}==>${NC} $*"; }
warn() { echo -e "${YLW}  WARN:${NC} $*"; }

# ── Core helpers ───────────────────────────────────────────────────────────────
need() { command -v "$1" &>/dev/null; }

symlink() {
  local src="$1" dst="$2" label="$3"
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    echo -e "    ${DIM}✓ already linked:  $label${NC}"
    return
  fi
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    warn "Backing up existing $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
  echo -e "    ${GRN}✓ linked:${NC}          $label"
}

apt_pkg() {
  local pkg="$1"
  if dpkg -s "$pkg" &>/dev/null 2>&1; then
    echo -e "    ${DIM}✓ already installed: $pkg${NC}"
  else
    log "apt install $pkg"
    sudo apt-get install -y "$pkg"
  fi
}

brew_pkg() {
  local pkg="$1"
  if brew list "$pkg" &>/dev/null 2>&1; then
    echo -e "    ${DIM}✓ already installed: $pkg${NC}"
  else
    log "brew install $pkg"
    brew install "$pkg"
  fi
}

omz_plugin() {
  local name="$1" repo="$2"
  local dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$name"
  if [[ -d "$dir" ]]; then
    echo -e "    ${DIM}✓ already installed: omz/$name${NC}"
  else
    log "Installing OMZ plugin: $name"
    git clone --depth=1 "$repo" "$dir"
  fi
}

# ── Interactive checkbox menu ──────────────────────────────────────────────────
# Args: "Title" item1 item2 …
# Sets global CHOSEN=() with selected items after user confirms.
checkbox_menu() {
  local title="$1"; shift
  local -a items=("$@")
  local -a sel
  for i in "${!items[@]}"; do sel[$i]=1; done

  while true; do
    printf '\033[2J\033[H'   # clear screen
    echo -e "${BLD}$title${NC}"
    echo ""
    for i in "${!items[@]}"; do
      if [[ ${sel[$i]} == 1 ]]; then
        printf "  ${GRN}[x]${NC} %d) %s\n" "$((i+1))" "${items[$i]}"
      else
        printf "  ${DIM}[ ]${NC} %d) %s\n" "$((i+1))" "${items[$i]}"
      fi
    done
    echo ""
    echo "  Enter number(s) to toggle  |  a = all  |  n = none  |  Enter = confirm"
    printf "> "; read -r input

    case "$input" in
      a)  for i in "${!items[@]}"; do sel[$i]=1; done ;;
      n)  for i in "${!items[@]}"; do sel[$i]=0; done ;;
      "") break ;;
      *)
        for num in $input; do
          [[ "$num" =~ ^[0-9]+$ ]] || continue
          local idx=$((num - 1))
          [[ $idx -ge 0 && $idx -lt ${#items[@]} ]] || continue
          [[ ${sel[$idx]} == 1 ]] && sel[$idx]=0 || sel[$idx]=1
        done
        ;;
    esac
  done

  CHOSEN=()
  for i in "${!items[@]}"; do
    [[ ${sel[$i]} == 1 ]] && CHOSEN+=("${items[$i]}")
  done
}

# ── Plan helpers (print what will happen without doing anything) ───────────────
plan_symlink() {
  local src="$1" dst="$2"
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    echo -e "    ${DIM}✓ $dst (already linked)${NC}"
  elif [[ -e "$dst" && ! -L "$dst" ]]; then
    echo -e "    ${YLW}~ $dst (existing file → will backup + replace)${NC}"
  else
    echo -e "    ${GRN}+ $dst${NC}"
  fi
}

plan_tool() {
  local cmd="$1" label="${2:-$1}"
  if need "$cmd"; then
    echo -e "    ${DIM}✓ $label ($(command -v "$cmd"))${NC}"
  else
    echo -e "    ${GRN}+ $label${NC}"
  fi
}

plan_dir() {
  local dir="$1" label="$2"
  if [[ -d "$dir" ]]; then
    echo -e "    ${DIM}✓ $label (already installed)${NC}"
  else
    echo -e "    ${GRN}+ $label${NC}"
  fi
}

# ── Component: zsh ─────────────────────────────────────────────────────────────
plan_zsh() {
  echo -e "  ${BLD}Symlinks${NC}"
  plan_symlink "$DOTFILES/zsh/.zshrc"  "$HOME/.zshrc"
  plan_symlink "$DOTFILES/zsh/.zshenv" "$HOME/.zshenv"
  echo -e "  ${BLD}Tools${NC}"
  plan_tool zsh
  plan_dir  "$HOME/.oh-my-zsh"                                               "oh-my-zsh"
  plan_dir  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab"         "omz: fzf-tab"
  plan_dir  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" "omz: zsh-autosuggestions"
  plan_dir  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting" "omz: fast-syntax-highlighting"
  plan_dir  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions" "omz: zsh-completions"
  plan_tool fzf
  plan_tool eza
  if [[ "$OS" == "Darwin" ]]; then
    plan_tool bat
    plan_tool fd
  else
    # Ubuntu: bat binary may be 'batcat', fd binary is 'fdfind'
    need bat || need batcat && \
      echo -e "    ${DIM}✓ bat (already installed)${NC}" || \
      echo -e "    ${GRN}+ bat${NC}"
    need fdfind && \
      echo -e "    ${DIM}✓ fd-find (already installed)${NC}" || \
      echo -e "    ${GRN}+ fd-find${NC}"
  fi
  plan_tool ag "ag (the_silver_searcher)"
  plan_tool zoxide
  plan_tool fastfetch
  echo -e "  ${BLD}Shell default${NC}"
  local zsh_path; zsh_path="$(command -v zsh 2>/dev/null || echo /usr/bin/zsh)"
  if [[ "$SHELL" == "$zsh_path" ]]; then
    echo -e "    ${DIM}✓ default shell already zsh${NC}"
  else
    echo -e "    ${GRN}+ chsh -s $zsh_path${NC}"
  fi
}

install_zsh() {
  log "Symlinks"
  symlink "$DOTFILES/zsh/.zshrc"  "$HOME/.zshrc"  "~/.zshrc"
  symlink "$DOTFILES/zsh/.zshenv" "$HOME/.zshenv" "~/.zshenv"

  log "zsh"
  if ! need zsh; then
    [[ "$OS" == "Darwin" ]] && brew_pkg zsh || sudo apt-get install -y zsh
  else
    echo -e "    ${DIM}✓ already installed: zsh${NC}"
  fi

  log "Oh My Zsh"
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    KEEP_ZSHRC=yes sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
      "" --unattended
  else
    echo -e "    ${DIM}✓ already installed${NC}"
  fi

  log "OMZ plugins"
  omz_plugin fzf-tab                  https://github.com/Aloxaf/fzf-tab
  omz_plugin zsh-autosuggestions      https://github.com/zsh-users/zsh-autosuggestions
  omz_plugin fast-syntax-highlighting https://github.com/zdharma-continuum/fast-syntax-highlighting
  omz_plugin zsh-completions          https://github.com/zsh-users/zsh-completions

  log "CLI tools"
  if [[ "$OS" == "Darwin" ]]; then
    need fzf       || brew_pkg fzf
    need eza       || brew_pkg eza
    need bat       || brew_pkg bat
    need fd        || brew_pkg fd
    need ag        || brew_pkg the_silver_searcher
    need zoxide    || brew_pkg zoxide
    need fastfetch || brew_pkg fastfetch
  else
    sudo apt-get update -qq

    # fzf via git clone (easily updatable with: git -C ~/fzf pull && ~/fzf/install --bin)
    if ! need fzf; then
      if [[ -d "$HOME/fzf" ]]; then
        git -C "$HOME/fzf" pull
      else
        git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/fzf"
      fi
      "$HOME/fzf/install" --bin
    else
      echo -e "    ${DIM}✓ already installed: fzf${NC}"
    fi

    # eza (not in Ubuntu apt before 23.10; use official deb repo as fallback)
    if ! need eza; then
      if apt-cache show eza &>/dev/null 2>&1; then
        sudo apt-get install -y eza
      else
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc \
          | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" \
          | sudo tee /etc/apt/sources.list.d/gierens.list
        sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
        sudo apt-get update -qq && sudo apt-get install -y eza
      fi
    else
      echo -e "    ${DIM}✓ already installed: eza${NC}"
    fi

    need bat || need batcat || apt_pkg bat
    need fdfind              || apt_pkg fd-find
    need ag                  || apt_pkg silversearcher-ag

    if ! need zoxide; then
      curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    else
      echo -e "    ${DIM}✓ already installed: zoxide${NC}"
    fi

    if ! need fastfetch; then
      sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch 2>/dev/null || true
      sudo apt-get update -qq
      sudo apt-get install -y fastfetch \
        || warn "fastfetch unavailable on this distro — skipping"
    else
      echo -e "    ${DIM}✓ already installed: fastfetch${NC}"
    fi
  fi

  log "Default shell"
  local zsh_path; zsh_path="$(command -v zsh)"
  if [[ "$SHELL" != "$zsh_path" ]]; then
    if ! grep -qF "$zsh_path" /etc/shells; then
      echo "$zsh_path" | sudo tee -a /etc/shells
    fi
    chsh -s "$zsh_path"
  else
    echo -e "    ${DIM}✓ already default${NC}"
  fi
}

# ── Component: starship ────────────────────────────────────────────────────────
plan_starship() {
  echo -e "  ${BLD}Symlinks${NC}"
  plan_symlink "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"
  echo -e "  ${BLD}Tools${NC}"
  plan_tool starship
}

install_starship() {
  log "Symlinks"
  symlink "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml" "~/.config/starship.toml"
  log "starship"
  if ! need starship; then
    if [[ "$OS" == "Darwin" ]]; then
      brew_pkg starship
    else
      mkdir -p "$HOME/.local/bin"
      curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir "$HOME/.local/bin" --yes
    fi
  else
    echo -e "    ${DIM}✓ already installed${NC}"
  fi
}

# ── Component: nvim ────────────────────────────────────────────────────────────
plan_nvim() {
  echo -e "  ${BLD}Symlinks${NC}"
  plan_symlink "$DOTFILES/nvim" "$HOME/.config/nvim"
  echo -e "  ${BLD}Note${NC}"
  echo    "    Plugins auto-install on first launch via lazy.nvim."
  echo    "    See nvim/SETUP.md for LSP server setup instructions."
}

install_nvim() {
  log "Symlinks"
  symlink "$DOTFILES/nvim" "$HOME/.config/nvim" "~/.config/nvim"
}

# ── Component: wezterm ─────────────────────────────────────────────────────────
plan_wezterm() {
  echo -e "  ${BLD}Symlinks${NC}"
  plan_symlink "$DOTFILES/wezterm" "$HOME/.config/wezterm"
}

install_wezterm() {
  log "Symlinks"
  symlink "$DOTFILES/wezterm" "$HOME/.config/wezterm" "~/.config/wezterm"
}

# ── Component: tmux ────────────────────────────────────────────────────────────
plan_tmux() {
  echo -e "  ${BLD}Symlinks${NC}"
  plan_symlink "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"
}

install_tmux() {
  log "Symlinks"
  symlink "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf" "~/.tmux.conf"
}

# ── Main ───────────────────────────────────────────────────────────────────────
COMP_KEYS=("zsh" "starship" "nvim" "wezterm" "tmux")
COMP_LABELS=(
  "zsh       — shell, Oh My Zsh, plugins + CLI tools (fzf, eza, bat, zoxide, fd, ag, fastfetch)"
  "starship  — cross-shell prompt"
  "nvim      — Neovim config symlink"
  "wezterm   — WezTerm config symlink"
  "tmux      — tmux config symlink"
)

# Phase 1: select components
checkbox_menu "Select components to set up:" "${COMP_LABELS[@]}"

if [[ ${#CHOSEN[@]} == 0 ]]; then
  echo "Nothing selected. Exiting."
  exit 0
fi

# Map chosen labels back to component keys
SELECTED=()
for choice in "${CHOSEN[@]}"; do
  for i in "${!COMP_LABELS[@]}"; do
    [[ "${COMP_LABELS[$i]}" == "$choice" ]] && SELECTED+=("${COMP_KEYS[$i]}")
  done
done

# Phase 2: show plan
printf '\033[2J\033[H'
echo -e "${BLD}Installation plan${NC}"
echo ""
for comp in "${SELECTED[@]}"; do
  echo -e "${BLD}[$comp]${NC}"
  "plan_$comp"
  echo ""
done

printf "Proceed? [Y/n] "; read -r confirm
[[ "$confirm" =~ ^[Nn] ]] && { echo "Aborted."; exit 0; }
echo ""

# Phase 3: install
for comp in "${SELECTED[@]}"; do
  echo ""
  echo -e "${BLD}━━━ $comp ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  "install_$comp"
done

echo ""
log "All done! Open a new terminal or run: exec zsh"
