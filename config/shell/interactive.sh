# Aliases
# --------------------------------------------- #
alias sps="sudo pacman -S"
alias spu="sudo pacman -Syu"

# alias sus="i3lock --color=81a1c1ff ; systemctl suspend"
alias s="systemctl"

alias backup_documents="rclone sync -v --filter-from ~/.config/rclone/filter.txt /home/ej/Documents/ google-drive:Documents/"

# improved ls
alias l="exa"
alias L="exa -la"

# Some Git alias
alias gg="git status"
alias ggd="git diff"
alias gga="git add"
alias ggc="git commit"
# --------------------------------------------- #

alias sus="systemctl suspend"
