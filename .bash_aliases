alias fucking="sudo"
alias diary="nvim ~/.config/diary"
alias gits="cd /home/lowell/Documents/gits"
alias sus="systemctl suspend"
#
# Add color aliases
alias grep="grep --color"
alias ls='ls --color=auto'

alias lsblk='lsblk -o NAME,MAJ:MIN,SIZE,FSUSE%,FSAVAIL,TYPE,FSTYPE,PARTLABEL,LABEL,MOUNTPOINTS,SERIAL,MODEL'
alias suser="sudo su -l \$(ls /home/ | fzf)"

# Set certain configuration files
alias tmux="tmux -f ~/.config/tmux/rc.conf"
alias info="info --init-file ~/.config/infokey"
alias scc-log="nvim All_Code_Folder/Supercomputing/scc24/docs/personal-sysadmin.log"
alias vim="nvim"
alias rofi="TERMINAL=/usr/bin/foot rofi"
