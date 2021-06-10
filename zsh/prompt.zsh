prompts() {
  PROMPT=$1
  RPROMPT=$2
  PS2=$3
}

prompt_char() { # by Steve Losh
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    bzr root >/dev/null 2>/dev/null && echo '↥' && return
    if (( $# == 0 )); then
      echo '$'
    else
      echo $1
    fi
}

virtualenv_info() {
    [ $VIRTUAL_ENV ] && echo ' ('`basename $VIRTUAL_ENV`')'
}

prompts '%{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(virtualenv_info) %{$fg[yellow]%}$(prompt_char)%{$reset_color%} ' 
