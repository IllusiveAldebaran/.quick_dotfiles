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

function screen_read(){
    wayshot -s "$(slurp)"
    mv *wayshot.png /tmp/
    tesseract-ocr /tmp/*wayshot.png stdout -l eng | wl-copy
    rm /tmp/*wayshot.png


}

function gdiff(){
  set -euo pipefail
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
  while [[ -n $stay ]] do
    #for i in "${commit_arr[@]}"; do
    git diff --color ${baseC} ${recentC} | less -R

    
    # choose to change start and or end commits

    # if [[ ans = 'first' ]]
    #
    # fi

    # pick new stuff
    stay=""
    echo -n "Options? Change commits [first/last/continue/quit]: "
    read -r ans
  done


}


function watch_wifi(){
	watch -n1 "awk 'NR==3 {print \"WiFi Signal Strength = \" \$3 \"00 %\"}''' /proc/net/wireless"
}
