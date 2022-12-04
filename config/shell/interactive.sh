# Aliases
# --------------------------------------------- #
alias sudo="sudo "
alias sps="sudo pacman -S"
alias spu="sudo pacman -Syu"

alias s="systemctl"

# Back up selected documents to Google Drive with rclone
alias backup_documents="rclone sync -v --filter-from ~/.config/rclone/filter.txt /home/ej/Documents/ google-drive:Documents/"

alias grep='grep -n --color=auto'

# Download and extract audio from YouTube videos
alias dlp='yt-dlp -x'

# bean-query command from Beancount
alias bq='bean-query'

# Easier mount and unmount with udisksctl
alias udmnt='udisksctl mount --block-device'
alias udumnt='udisksctl unmount --block-device'
alias udpwr='udisksctl power-off --block-device'

# improved ls
alias l="exa"
alias L="exa -la"

# Some Git alias
alias gg="git status"
alias ggd="git diff"
alias gga="git add"
alias ggc="git commit"
alias ggp="git push"

# Some PHP/Laravel aliases
alias art="php artisan"

# Network
alias lswifi="nmcli device wifi list"

alias sus="systemctl suspend"
