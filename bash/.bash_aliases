# display weather information in terminal
alias weather='curl wttr.in'

# update ubuntu box
alias update='sudo -- sh -c "apt update && apt upgrade && apt autoremove && apt autoclean"'

alias clean='sudo apt autoclean && sudo apt autoremove && sudo apt autopurge'

# install packages
alias install='sudo -- sh -c "apt install"'

# cd one out
alias ..='cd ..'
# cd two out
alias ...='cd ...'
# cd home
alias home='cd ~'

# display sorted file size
alias lt='ls --human-readable --size -1 -S --classify'

# show important devices
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"

# find a command in grep history
alias gh='history|grep'

# count files
alias count='find . -type f | wc -l'

# copy with progressbar
alias cpv='rsync -ah --info=progress2'

# move to trash bin
alias trash='mv --force -t ~/.local/share/Trash '

# always prompt before removing files
alias rm='rm -i'

# open vimrc
alias vimrc='nvim ~/.vimrc'

# open bashrc
alias bashrc='nvim ~/.bashrc'

alias vim='nvim'

# git
alias ginit='git init'
alias gadd='git add'
alias gstat='git status'
alias gpush='git push'
alias gpull='git pull'
alias gdiff='git diff'
alias gpushmaster='git push origin master'
alias glog='git log'
alias gmain='git checkout main'
alias gmaster='git checkout master'
alias gout='git checkout'
alias gbranch='git checkout -b'
alias gres='git restore'
