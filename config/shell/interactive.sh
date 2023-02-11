# Aliases
# --------------------------------------------- #
alias sudo="sudo "
alias sps="sudo pacman -S"
alias spu="sudo pacman -Syu"

alias s="systemctl"

# Back up selected documents to Google Drive with rclone
alias backup_docs_to_google="rclone sync -v --filter-from ~/.config/rclone/filter.txt /home/ej/Documents/ google-drive:Documents/"

alias backup_docs_to_mega="rclone sync -v --filter-from ~/.config/rclone/filter.txt /home/ej/Documents/ mega:Documents/"

alias grep='grep -n --color=auto'

# Recursive grep starting in current directory
rgrep() {
  if [ "$#" -eq 1 ]; then
    grep -r "${1}" ./
  fi
}

# Download and extract audio from YouTube videos
alias dlp='yt-dlp -x'

# Use loudgain to normalize opus or mp3 albums
alias lg_mp3='loudgain -I3 -S -L -a -k -s e *.mp3'
alias lg_opus='loudgain -a -k -s e *.opus'

# bean-query command from Beancount
alias bq='bean-query'

# Easier mount and unmount with udisksctl
alias udmnt='udisksctl mount --block-device'
alias udumnt='udisksctl unmount --block-device'
alias udpwr='udisksctl power-off --block-device'

# improved ls
alias l="exa"
alias L="exa -la"

# Jupyter notebook and lab
alias jnb="jupyter notebook"
alias jnl="jupyter lab"

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
