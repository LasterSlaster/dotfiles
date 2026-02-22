# Fast mode for non-interactive shells (AI/LLM background commands)
# This speeds up Cursor AI's shell commands while keeping your integrated terminal normal
if [[ ! -o interactive ]] || [[ ! -t 0 ]]; then
    # No TTY attached = background AI command, not user's terminal
    if [[ "$(uname)" == "Darwin" ]]; then
        export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
    else
        export PATH="/home/linuxbrew/.linuxbrew/bin:/usr/local/bin:$PATH"
    fi
    # Skip Oh My Zsh loading
    return 0 2>/dev/null || exit 0
fi

# Ensure user-local bin is in PATH early (needed for starship, fzf, etc.)
export PATH="$HOME/.local/bin:$PATH"

# lesspipe for better less with non-text input files (no-op on macOS where lesspipe isn't present)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""  # Disabled: starship handles the prompt

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# Build plugin list dynamically — only include plugins that are actually installed
plugins=(git)
_omz_custom="${ZSH_CUSTOM:-$ZSH/custom}"
[[ -d "$_omz_custom/plugins/fzf-tab" ]]               && plugins+=(fzf-tab)
[[ -d "$_omz_custom/plugins/zsh-autosuggestions" ]]   && plugins+=(zsh-autosuggestions)
[[ -d "$_omz_custom/plugins/fast-syntax-highlighting" ]] && plugins+=(fast-syntax-highlighting)
[[ -d "$_omz_custom/plugins/zsh-completions" ]]       && plugins+=(zsh-completions)
unset _omz_custom

[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"
command -v starship &>/dev/null && eval "$(starship init zsh)"

command -v kubectl &>/dev/null && source <(kubectl completion zsh)

# Load fzf key bindings and completion if they exist
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

# fdd - cd to selected directory
fdd() {
  local dir
  dir=$(find ${1:-.} -path '*/.*' -prune -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fh - search in your command history and execute selected command
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# alias for cd
command -v zoxide &>/dev/null && eval "$(zoxide init --cmd z zsh)"
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gP="git push"
alias gp="git pull"
alias gcm="git commit -m" # TODO: install and use commitizen!?
alias gcma="git add -A && git commit -m" # TODO: install and use commitizen!?
alias gl="git log --oneline --graph --decorate --all"
alias gud="git reset --soft HEAD~1"   # Undo last commit
alias gcb="git checkout -b"   # Create and switch to a new branch
if command -v eza &>/dev/null; then
  alias ls="eza --icons=always --color=always --long --git"
  alias ll="eza --icons=always --color=always --long --all --git"
  alias lt="eza --icons=always --color=always --long --git --tree"
fi
command -v bat  &>/dev/null && alias cat="bat"
command -v nvim &>/dev/null && alias vim="nvim"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cdc="cd ~/repos"
alias docs="cd ~/Documents"
alias dl="cd ~/Downloads"
alias zconf="nvim ~/.zshrc"
if [[ "$(uname)" == "Darwin" ]]; then
  alias cconf="nvim ~/Library/Application\ Support/Code/User/settings.json"
  alias update="brew update && brew upgrade && brew cleanup"
else
  alias cconf="nvim ~/.config/Code/User/settings.json"
  alias update="sudo apt update && sudo apt upgrade"
fi
alias cpu="htop --sort-key PERCENT_CPU"
alias mkdir="mkdir -p"   # Create nested directories

cd() {
  if (( $+functions[z] )); then
    z "$@"
  else
    builtin cd "$@"
  fi
  (( $+commands[eza] )) && eza --icons=always --color=always --long --all --git
}

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
## [/Completion]
export EDITOR='nvim'

setopt share_history
#History
HISTSIZE=5000
HISTFILE=~/zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups

setopt GLOB_DOTS
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd or eza/ls
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=always --color=always --long --git -1 $realpath'
zstyle ':fzf-tab:complete:eza:*' fzf-preview 'eza --icons=always --color=always --long --git -1 $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# FZF configuration
export FZF_COMPLETION_TRIGGER="**"
if command -v ag &>/dev/null; then
  export FZF_DEFAULT_COMMAND="ag --depth=50 --hidden --ignore=.git --ignore=.idea -g ''"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

_fzf_compgen_path() {
    ag --hidden --ignore=.git --ignore=.idea -g '' "${1:-.}"
}

_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "${1:-.}"
}

command -v fzf &>/dev/null && eval "$(fzf --zsh)"

extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz) tar xzf "$1" ;;
      *.bz2) bunzip2 "$1" ;;
      *.rar) unrar x "$1" ;;
      *.gz) gunzip "$1" ;;
      *.tar) tar xf "$1" ;;
      *.tbz2) tar xjf "$1" ;;
      *.tgz) tar xzf "$1" ;;
      *.zip) unzip "$1" ;;
      *.Z) uncompress "$1" ;;
      *.7z) 7z x "$1" ;;
      *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

psgrep() {
  ps aux | grep -i "$1" | grep -v grep
}

command -v fastfetch &>/dev/null && fastfetch
if [[ "$(uname)" == "Darwin" ]]; then
  export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
  export PATH="$PATH:$HOME/.pub-cache/bin"
  export PATH="$HOME/fvm/default/bin:$PATH"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Ignore dotfiles (like .run) from spelling correction
CORRECT_IGNORE_FILE='.*'
export KUBECONFIG=~/.kube/config_dev
export PATH="$HOME/.local/bin:$PATH"
if [[ "$(uname)" == "Darwin" ]]; then
  alias swilog-dev="cd $HOME/repos/swila && ./scripts/start.sh dev"
  alias swilog-stop="cd $HOME/repos/swila && docker-compose -f docker-compose.dev.yml down"
fi


# nvm (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# Load Angular CLI autocompletion.
command -v ng &>/dev/null && source <(ng completion script)
alias flutterfire="dart run flutterfire_cli:flutterfire"


if [[ "$(uname)" == "Darwin" ]]; then
  export STM32_PRG_PATH=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin
fi
