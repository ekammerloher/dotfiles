HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history # Save timestamp and duration
setopt append_history # Append history file instead of an overwrite
setopt share_history # Share history across sessions
setopt inc_append_history # Append lines as soon as they are entered
setopt hist_ignore_dups # Ignore duplicates of previous command
setopt hist_reduce_blanks # Remove superfluous blanks
setopt hist_expire_dups_first # Expire duplicates before unique commands
setopt hist_verify # Commands from history are not executed at once
setopt hist_find_no_dups # Omit not contiguous duplicates from search
setopt interactive_comments # Add comments with '#' in interactive sessions

setopt auto_cd # Cd can be omitted for directories. .. instead of cd ..

REPORTTIME=10 # Display CPU stats for commands taking more than 10 seconds

bindkey -v # Enable vi mode

#zstyle :compinstall filename '/Users/eugen/.zshrc'

autoload -Uz compinit # Intelligent tab completion
compinit
#autoload -Uz promptinit
#promptinit
# Custome prompt
#PROMPT="[%*] %1~/ %F{green}%B%#%b%f "
PROMPT="[%*] %1~/ %B%#%b "

setopt transient_rprompt # do not display modes for previously accepted lines

# This is a hack, since the very first line after starting zsh does not evoke
# the zle widgets otherwise
precmd() {
  RPROMPT=""
}

# Show vi normal mode, works for commands on one line
function zle-line-init zle-keymap-select {
  if [ $KEYMAP = vicmd ]; then
    RPROMPT="%B-- NORMAL --%B"
  else
    RPROMPT=""
  fi
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Does not work with tmux
#KEYTIMEOUT=1 # Set delay to 10ms for faster vi mode change
# Map viins to jj. This is a more elegant way than using KEYTIMEOUT
# set to low values
bindkey -M viins 'jj' vi-cmd-mode

export CLICOLOR=1 # Enable color in command output

export PATH="/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"

alias ls='ls -Fh' # Show slash on directories etc. and print pretty size
alias tree='tree -C' # Add color to tree command

# Simple wrapper around curl to download videos
# to file ~/Downloads/a.mp4 or ~/Downloads/b.mp4
#curl -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36' -g -o ~/Downloads/a.mp4 "$1"
alias ca='curl -g -o ~/Downloads/a.mp4'
alias cb='curl -g -o ~/Downloads/b.mp4'

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
# To have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
# Match comments and color them magenta
ZSH_HIGHLIGHT_PATTERNS+=('\#*' 'fg=magenta,bg=default')

# bind UP and DOWN arrow keys (this work for OS X)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
