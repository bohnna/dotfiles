# Correction
setopt correct_all
alias man='nocorrect man'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias mkdir='nocorrect mkdir'
alias erl='nocorrect erl'
alias curl='nocorrect curl'
alias rake='nocorrect rake'
alias make='nocorrect make'
alias cake='nocorrect cake'
alias lessc='nocorrect lessc'
alias lunchy='nocorrect lunchy'
SPROMPT="$fg[red]%R →$reset_color $fg[green]%r?$reset_color (Yes, No, Abort, Edit) "
