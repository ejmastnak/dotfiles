# Recursive grep starting in current directory
rgrep() {
  if [ "$#" -eq 1 ]; then
    grep -r "${1}" ./
  fi
}

# Turn displays on
display-on() {
  if [[ "$#" -ne 1 ]]; then
    exit
  fi
  if [[ ${1} -eq 0 ]]; then
    xrandr --output eDP-1 --auto
  elif [[ ${1} -eq 1 ]]; then
    xrandr --output HDMI-1 --auto
  elif [[ ${1} -eq 2 ]]; then
    xrandr --output HDMI-2 --auto
  fi
}

# Turn displays off
display-off() {
  if [[ "$#" -ne 1 ]]; then
    exit
  fi
  if [[ ${1} -eq 0 ]]; then
    xrandr --output eDP-1 --off
  elif [[ ${1} -eq 1 ]]; then
    xrandr --output HDMI-1 --off
  elif [[ ${1} -eq 2 ]]; then
    xrandr --output HDMI-2 --off
  fi
}

alias tbird='thunderbird'
alias py='python'
alias se='sudoedit'
alias mpvs='mpv --shuffle ./'

alias grep='grep --color=auto'

# Activate Python virtual environment
alias venv="source ./venv/bin/activate && vifm ./ ./"

# Download and extract audio from YouTube videos
alias dlp='yt-dlp --extract-audio --audio-format mp3'
alias ydlp='yt-dlp -S res:720'

# Use loudgain to normalize opus or mp3 albums
alias lg_mp3='loudgain -I3 -S -L -a -k -s e *.mp3'
alias lg_opus='loudgain -a -k -s e *.opus'

# bean-query command from Beancount
alias bq='bean-query'

# Some Git alias
alias gg="git status"
alias ggd="git diff"
alias gga="git add"
alias ggc="git commit"
alias ggp="git push"
alias ggpm="git push prod main"
alias ggl="git log"
alias ggb="git branch"
alias ggr="git restore"
alias ggs="git switch"
alias ggi="git init"
alias ggls="git ls-files"

# Some PHP/Laravel aliases
alias art="php artisan"
alias artmfs="php artisan migrate:fresh --seed"
alias artt="php artisan tinker"
alias artrl="php artisan route:list"

# Network
alias lswifi="nmcli device wifi list"

# Easier shortcut for music.py script
alias mp="music.py"
alias mpy="music.py youtube"

# Easier shortcut for backup-documents.bash script
alias bdb="backup-documents.bash"
