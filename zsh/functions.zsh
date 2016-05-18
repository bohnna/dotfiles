#
# Make and cd into a directory

mcd() { 
    mkdir -p "$1" && cd "$1"; 
}

#
# Show how much RAM application uses.
# $ ram safari
# # => safari uses 154.69 MBs of RAM.

function ram() {
  local sum
  local items
  local app="$1"
  if [ -z "$app" ]; then
    echo "First argument - pattern to grep from processes"
  else
    sum=0
    for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
      sum=$(($i + $sum))
    done
    sum=$(echo "scale=2; $sum / 1024.0" | bc)
    if [[ $sum != "0" ]]; then
      echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
    else
      echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
    fi
  fi
}

#
# $ size dir1 file2.js

function size() {
  # du -sh "$@" 2>&1 | grep -v '^du:' | sort -nr
  du -shck "$@" | sort -rn | awk '
      function human(x) {
          s="kMGTEPYZ";
          while (x>=1000 && length(s)>1)
              {x/=1024; s=substr(s,2)}
          return int(x+0.5) substr(s,1,1)
      }
      {gsub(/^[0-9]+/, human($1)); print}'
}

#
# Monitor IO in real-time (open files etc).

function openfiles() {
  sudo dtrace -n 'syscall::open*:entry { printf("%s %s",execname,copyinstr(arg0)); }'
}

#
# Find a file/pattern within a specified directory
function ff() {
    find . -iname "*${1:-}*"
}

path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
           sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
           sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
           sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
           sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
           print }"
}

up() { # https://gist.github.com/1474072
    if [ "$1" != "" -a "$2" != "" ]; then
        local DIR=$1
        local TARGET=$2
    elif [ "$1" ]; then
        local DIR=$PWD
        local TARGET=$1
    fi
    while [ ! -e $DIR/$TARGET -a $DIR != "/" ]; do
        DIR=$(dirname $DIR)
    done
    test $DIR != "/" && echo $DIR/$TARGET
}

chpwd() {
  if [[ -n "$TMUX" ]]; then
    tmux setenv "$(tmux display -p 'TMUX_PWD_#D')" "$PWD"
    tmux refresh-client -S
  fi
}

if has_brew; then
    gimme() { brew install $1 }
    _gimme() { reply=(`brew search`) }

elif has_apt; then
    gimme() { sudo apt-get install $1 }

elif has_yum; then
    gimme() { su -c 'yum install $1' }

fi

if is_mac; then

    pman() { man $1 -t | open -f -a Preview } # open man pages in Preview
    cdf() { eval cd "`osascript -e 'tell app "Finder" to return the quoted form of the POSIX path of (target of window 1 as alias)' 2>/dev/null`" }

    vol() {
        if [[ -n $1 ]]; then osascript -e "set volume output volume $1"
        else osascript -e "output volume of (get volume settings)"
        fi
    }

    locatemd() { mdfind "kMDItemDisplayName == '$@'wc" }

    evernote() {
        if [[ -n $1 ]]; then msg=$1
        else msg=$(cat | sed -e 's/\\/\\\\/g' -e 's/\"/\\\"/g')
        fi
        osascript -e 'tell application "Evernote" to open note window with (create note with text "'$msg'")' -e 'tell application "Evernote" to activate'
    }

    # http://apple.stackexchange.com/questions/5435/got-any-tips-or-tricks-for-terminal-in-mac-os-x?page=2&tab=votes#tab-top
    quit() {
        for app in $*; do
            osascript -e 'quit app "'$app'"'
        done
    }

    relaunch() {
        for app in $*; do
            osascript -e 'quit app "'$app'"';
            sleep 2;
            open -a $app
        done
    }

    selected() {
      osascript <<EOT
        tell application "Finder"
          set theFiles to selection
          set theList to ""
          repeat with aFile in theFiles
            set theList to theList & POSIX path of (aFile as alias) & "\n"
          end repeat
          theList
        end tell
EOT
    }
fi
