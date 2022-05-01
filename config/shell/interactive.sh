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

function sus() {
  i3lock --color=81a1c1ff \
    --radius 110 \
    --inside-color=d8dee9ff \
    --insidever-color=d8dee9ff \
    --ringver-color=5e81acff \
    --insidewrong-color=bf616aff \
    --ringwrong-color=bf616aff \
    --line-uses-inside \
    --ring-color=5e81acff \
    --separator-color=5e81acff \
    --keyhl-color=81a1c1ff \
    --bshl-color=5e81acff \
    --verif-text="Verifying..." \
    --wrong-text="Incorrect." \
    --verif-color=2e3440ff \
    --wrong-color=2e3440ff \
    --modif-color=2e3440ff \
    --layout-color=2e3440ff \
    --time-color=2e3440ff \
    --date-color=2e3440ff \
    --greeter-color=2e3440ff \
    --time-font="Iosevka" \
    --date-font="Iosevka" \
    --layout-font="Iosevka" \
    --verif-font="Iosevka" \
    --wrong-font="Iosevka" \
    --greeter-font="Iosevka"

  systemctl suspend
}
