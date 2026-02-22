# ~/.zshenv — sourced for ALL zsh invocations (interactive, login, scripts)
# Keep this file minimal: only set things every shell instance needs.

# Tell Ubuntu's /etc/zsh/zshrc not to call compinit — Oh My Zsh handles it.
# Without this, compinit runs twice: once from /etc/zsh/zshrc and once from OMZ,
# which can break plugin hook registration (fast-syntax-highlighting, fzf-tab).
skip_global_compinit=1
