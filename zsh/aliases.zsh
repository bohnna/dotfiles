alias ..='cd ..'
alias ....='cd ../..'
alias la='ls -la'
alias ll='ls -l'
alias lst="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
alias clr='clear'
alias s_http='python -m SimpleHTTPServer' # serve current folder via HTTP
alias s_smtp='python -m smtpd -n -c DebuggingServer localhost:1025' # SMTP test server, outputs to console
alias wget='wget --no-check-certificate'
alias pinst='sudo python setup.py install && sudo rm -r build && sudo rm -r dist && sudo rm -r *egg-info' # install a Python package
alias beep='echo -n "\a"'
alias pullstaging="wordmove pull -d -e staging && wordmove pull -u -e staging && wordmove pull -p -e staging && wordmove pull -m -e staging && git pull"
alias pullprod="wordmove pull -d -e production && wordmove pull -u -e production && wordmove pull -p -e production && wordmove pull -m -e production && git pull"
alias pushstaging="wordmove push -d -e staging && wordmove push -u -e staging && wordmove push -p && wordmove push -m -e staging && wordmove push -t -e staging"
alias pushprod="wordmove push -d -e production && wordmove push -u -e production && wordmove push -p -e production && wordmove push -t -e production"
alias simulator="open -n /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
alias listusage="du -ah . | sort -rn | head -20"
alias nodeplz="npm install"
alias fucknode="rm -rf node_modules && rm -rf bower_components"
alias killcache="dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

if is_mac; then
    alias ql='qlmanage -p 2>/dev/null' # OS X Quick Look
    alias oo='open .' # open current dir in OS X Finder
    alias rm='trash' # Move deleted items to the trash (Do brew install trash first)
fi

if [[ -x "`whence -p dircolors`" ]]; then
	eval `dircolors`
	alias ls='ls -F --color=auto'
else
	alias ls='ls -F'
fi
