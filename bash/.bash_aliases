# regular aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias c='clear'
alias m='less -r'
alias md='mkdir'
alias rd='rmdir'
alias q='clear;exit'
alias t='htop -d 10'
alias ls='ls -hF --color'
alias ll='ls -Al --color'
alias la='ls -A --color'
alias l='ls -l --color'
alias df='df -h'
alias du='du -h'
alias r='R --save'
alias n='neofetch'
alias s='sensors'
alias f='free -h'
alias v='vi'
alias vf='~/.config/vifm/scripts/vifmrun .'
alias i='inxi -Fxxxrz'
alias update='sudo apt update'
alias upgradable='sudo apt list --upgradable'
alias upgrade='sudo apt update && sudo apt upgrade -y'
alias clean='sudo apt autoclean && sudo apt autoremove -y'
alias reboot='sudo reboot now'
alias log='clear && tail /var/log/syslog -n 20'
alias bootlog='clear && sudo tail /var/log/boot.log -n 100'

# git aliases
alias gstat='git status'
alias gadd='git add .'
alias gpush='git push'
alias gpull='git pull'
gcommit() {
    git commit -m "$1"
}

# fzf aliases
alias ff='fzf --preview="head -$LINES {}" | xargs -r -I % xed %'
alias fd='cd $HOME/Documents && fzf --preview="head -$LINES {}" | xargs -r -I % xed %'
alias FF='cd $HOME && fzf --preview="head -$LINES {}" | xargs -r -I % xed %'
