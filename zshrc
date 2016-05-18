PATH="$PATH:$HOME/.rvm/bin:/usr/local/bin:/usr/local/sbin:~/bin:~/bin/FDK/Tools/osx:./node_modules/.bin"
FDK_EXE="~/bin/FDK/Tools/osx"

export PATH
export FDK_EXE
export EDITOR=nvim
export VISUAL=$EDITOR
export TERMINFO="$HOME/.terminfo"

autoload -U colors && colors;

setopt correct
setopt hist_ignore_dups
setopt complete_in_word
setopt path_dirs
setopt append_history
setopt inc_append_history
setopt auto_name_dirs
setopt pushd_ignore_dups
setopt prompt_subst
setopt no_beep
setopt auto_cd
setopt multios
setopt cdablevarS
setopt transient_rprompt
setopt extended_glob
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
autoload -U zmv
bindkey "^[m" copy-prev-shell-word
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt share_history
setopt append_history
setopt hist_verify
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_space

HISTFILE=~/.history
HISTSIZE=1000
SAVEHIST=1000

# Checks
is_mac() { [[ $OSTYPE == darwin* ]] }
is_linux() { [[ $OSTYPE == linux-gnu ]] }
has_brew() { [[ -n ${commands[brew]} ]] }
has_apt() { [[ -n ${commands[apt-get]} ]] }
has_yum() { [[ -n ${commands[yum]} ]] }
#
# RVM or rbenv
#
export RBENV_ROOT=$HOME/.rbenv
[[ -d /usr/local/var/rbenv ]] && export RBENV_ROOT=/usr/local/var/rbenv
if [[ -s $HOME/.rvm/scripts/rvm ]]; then
    source $HOME/.rvm/scripts/rvm
    RUBY_VERSION_PREFIX='r'
    ruby_version() {
        if [[ $RUBY_VERSION != "" ]]; then
            echo $RUBY_VERSION_PREFIX$RUBY_VERSION | sed s/ruby-//
        else echo ''; fi
    }
elif [[ -d $RBENV_ROOT ]]; then
    export PATH=$PATH:$RBENV_ROOT/bin
    eval "$(rbenv init -)"
    ruby_version() { rbenv version-name }
else
    ruby_version() { echo '' }
fi

# Load all files in ~/.zsh
for function in ~/.zsh/*; do
  source $function
done

# Load local customizations
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
