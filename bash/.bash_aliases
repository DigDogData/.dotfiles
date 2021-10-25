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
alias du='du -h --max-depth=1'
alias r='R --save'
alias n='neofetch'
alias nw='newsboat'
alias s='sensors'
alias f='free -h'
alias v='vi'
alias vf='~/.config/vifm/scripts/vifmrun .'
alias py='pipenv run python'
alias ipy='pipenv run ipython'
alias i='inxi -Fxxxrz'
alias update='sudo apt update'
alias upgradable='sudo apt list --upgradable'
alias upgrade='sudo apt update && sudo apt upgrade -y'
alias clean='sudo apt autoclean && sudo apt autoremove -y'
alias reboot='sudo reboot now'
alias log='clear && tail /var/log/syslog -n 20'
alias bootlog='clear && sudo tail /var/log/boot.log -n 100'
alias xampp='sudo /opt/lampp/manager-linux-x64.run'
alias y='youtube-dl'
alias yx='youtube-dl -x --audio-format mp3 --prefer-ffmpeg'
alias yxp='youtube-dl -x --audio-format mp3 --prefer-ffmpeg --yes-playlist'

# fzf aliases
alias ff='fzf --preview="head -$LINES {}" --preview-window="right:50%" --bind="ctrl-/:toggle-preview" | xargs -r -I % xed %'    # open in xed
#alias ff='vi $(fzf --preview="head -$LINES {}" --preview-window="right:50%" --bind="ctrl-/:toggle-preview")'   # open in vim
alias fd='cd $HOME/Documents && fzf --preview="head -$LINES {}" --preview-window="right:50%" --bind="ctrl-/:toggle-preview" | xargs -r -I % xed %'
#alias fd='cd $HOME/Documents && vi $(fzf --preview="head -$LINES {}" --preview-window="right:50%" --bind="ctrl-/:toggle-preview")'
alias FF='cd $HOME && fzf --preview="head -$LINES {}" --preview-window="right:50%" --bind="ctrl-/:toggle-preview" | xargs -r -I % xed %'
alias Rg='rga'
#alias Rg='rg --column --line-number --no-heading --hidden --smart-case "${*:-}" | fzf --delimiter : --preview "head -$LINES {1}" --preview-window="right:50%" --bind="ctrl-/:toggle-preview"'
