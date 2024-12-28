## Fancy prompt
red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
black='\[\e[0;30m\]'
BLACK='\[\e[1;30m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;33m\]'
magenta='\[\e[0;35m\]'
MAGENTA='\[\e[1;35m\]'
white='\[\e[0;37m\]'
WHITE='\[\e[1;37m\]'
NC='\[\e[0m\]'

function is_vim_running {
  jobs | grep -o 'vim' &> /dev/null
}

# Aliases
alias l='ls -CF'
alias ls='ls -hF --color=auto'
alias ll='ls -hFl --color=auto'
alias la='ls -lhAF --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias mkdir='mkdir -p'
alias df='df -h'
alias du='du -hc'
alias nvim='vim' # I don't want to install neovim, but I keep writing nvim instead of vim
alias bat='batcat'

# Security
alias rm='rm -i --preserve-root'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias sudo='sudo ' # Expand aliases with sudo too

## Shopt options
shopt -s cdspell        # This will correct minor spelling errors in cd command.
shopt -s checkwinsize   # Check window size (rows, columns) after each command.
shopt -s cmdhist        # Save multi-line commands in history as single line.
shopt -s direxpand      # Allow to type partial directory names..
shopt -s dirspell       # ..and let bash spell them out for you.
shopt -s dotglob        # Include dotfile in path-name expansions.
shopt -s globstar       # Enable recursive globbing with **.
shopt -s histappend     # Append to history rather than overwrite.
shopt -s nocaseglob     # Pathname expansion will be treated as case-insensitive.
stty -ixon              # Disable console start/stop: makes ^S and ^Q go through

# Bash completion (must install bash-completion package)
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Exports
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL="ignoreboth"
export EDITOR="vim"
export PAGER="less"
export LESS="-R"
export TERM="xterm-256color"

PROMPT_INFO="${white}[\A] ${blue}\u${NC}@${red}\h${NC}:${blue}\w"
PROMPT_GIT="${green}\$(__git_ps1)"
PROMPT_SUFFIX="${NC}\$ "

PS1="${PROMPT_INFO}${PROMPT_GIT} ${PROMPT_SUFFIX}"

[ -f ~/.dotfiles/functions ] && source ~/.dotfiles/functions

