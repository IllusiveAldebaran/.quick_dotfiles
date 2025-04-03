#!/bin/bash --
if [[ -d /etc/bash_completion.d ]] && ls /etc/bash_completion.d/* &>/dev/null; then 
  source /etc/bash_completion.d/*
fi

function math(){
    rofi -show calc -modi calc -no-show-match -no-sort
}
function emoji(){
    rofi -modi emoji -show emoji
}

function screenshot(){
    wayshot -s "$(slurp)" --stdout | wl-copy
}

# Move dir(s)/file and place a symbolic link in its place
# https://unix.stackexchange.com/questions/228015/move-a-file-and-replace-it-by-a-symlink
function ml(){
  while [ $# -gt 1 ]; do
    eval "target=\${$#}"
    original="$1"
    if [ -d "$target" ]; then
      target="$target/${original##*/}"
    fi
    mv -- "$original" "$target"
    case "$original" in
      */*)
        case "$target" in
          /*) :;;
          *) target="$(cd -- "$(dirname -- "$target")" && pwd)/${target##*/}"
        esac
    esac
    ln -s -- "$target" "$original"
    shift
  done
}

# Needs to be called with quotation marks around url, and only call with one url at a time followed by genres
# Ex: add-song "https://music.youtube.com/watch?v=2-LQqnyNYiQ&si=4X3DpDq_MEIBlCf1" anime
function add-song(){
  # For adding a playlist: youtube-dl -o "%(playlist_index)s-%(title)s.%(ext)s"
  # Also try to add --embed-metadata later
  # yt-dlp --extract-audio --embed-metadata --audio-format mp3 --audio-quality 0 -o "%(playlist_index)s-%(title)s.%(ext)s" "$1"
  
  dir0="random"

  if [[ $# -gt 1 && -d ~/Audio/Music/"$2" ]]; then
      dir0="$2"
  fi

  printf "Putting song in %s directory\n" "${dir0}"

  (
  cd ~/Audio/Music/"$dir0" && notify-send "Adding Song"|| notify-send "Failed"
  yt-dlp --extract-audio --embed-metadata --audio-format mp3 --audio-quality 0 -o "%(playlist_index)s-%(title)s === [%(id)s].%(ext)s" "${1}" > /dev/null &
  )
}

function screen_read(){
    filetmp=$(mktemp wayshot-XXXX.png)
    trap 'rm "$filetmp"' EXIT
    wayshot -s "$(slurp)" -f "$filetmp"
    tesseract-ocr "$filetmp" stdout -l eng | wl-copy
}

function gdiff(){
  #set -euo pipefail
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
    git diff --color "${baseC}" "${recentC}" | less -R

    
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
  browser-sync start --server --files "$1" --startPath "$1"
}

function watch_wifi(){
	watch -n1 "awk 'NR==3 {print \"WiFi Signal Strength = \" \$3 \"00 %\"}''' /proc/net/wireless"
}


function ssh(){
  TERM=xterm-256color;
  if [[ -z $SSH_AUTH_SOCK ]]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_rsa 2> /dev/null # github uses this one, but using command without arguments tries default keys anyways, id_{rsa,ed25519,ecdsa,etc...}
  fi
  command ssh -A "$@"
}
