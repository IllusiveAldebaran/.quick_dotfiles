#!/bin/bash
source /etc/bash_completion.d/*

function screenshot(){
    wayshot -s "$(slurp)" --stdout | wl-copy
    #WAYSHOT_TMP="/tmp/wayshot-$(USER)"
    #echo $WAYSHOT_TMP 
    #wayshot -s "$(slurp)"
    #cat $WAYSHOT_TMP | wl-copy;
    #rm $WAYSHOT_TMP
}

# Needs to be called with quotation marks around url, and only call with one url at a time followed by genres
# Ex: add-song "https://music.youtube.com/watch?v=2-LQqnyNYiQ&si=4X3DpDq_MEIBlCf1" anime
function add-song(){
  
  dir0="random"

  if [[ $# -gt 1 && -d ~/Audio/Music/"$2" ]]; then
      dir0="$2"
  fi

  printf "Putting song in $2 directory\n"

  (
  cd ~/Audio/Music/$dir0
  yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 "$1"
  )
}

function screen_read(){
    filetmp=$(mktemp -t wayshot-XXXX.png)
    wayshot -s "$(slurp)" 
    mv [0-9]*-wayshot.png $filetmp
    tesseract-ocr $filetmp stdout -l eng | wl-copy
    rm $filetmp


}

function gdiff(){
  set -euo pipefail
  # TODO check if there exists .git/

  if [[ ! -d .git/ ]]; then
    echo Not in a git repo. Exiting...
    return
  fi



  # create an array of the commits
  commit_arr=($(git log --oneline | awk '{print $1}'))

  # latest commit and a control group commit
  recentC=${commit_arr[0]}
  baseC=${commit_arr[1]}

  choice="checkdiff"


  

  # loop that gives options: quit, change end or start.
  echo "> git diff ${baseC} ${recentC}"
  echo -n "Options? Change commits [[f]irst/[l]ast/[c]ontinue/[q]uit]: "
  read -r checkdiff
  while [[ -n $stay ]]; do
    #
    #for i in "${commit_arr[@]}"; do
    git diff --color ${baseC} ${recentC} | less -R

    
    # choose to change start and or end commits

    if [[ ${ans:0:1} == 'f' ]]; then
      echo 'Change first'
    fi

    # pick new stuff
    stay=""
    echo -n "Options? Change commits [first/last/continue/quit]: "
    read -r ans
  done


  return

}

# requires browser-sync, installed with npm
function sync-html(){
  browser-sync start --server --files $1 --startPath $1
}

function watch_wifi(){
	watch -n1 "awk 'NR==3 {print \"WiFi Signal Strength = \" \$3 \"00 %\"}''' /proc/net/wireless"
}


function ssh(){
  TERM=xterm-256color;
  if [[ -z $SSH_AUTH_SOCK ]]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_rsa 2> /dev/null
  fi
  command ssh "$@"
}
