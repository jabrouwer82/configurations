# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.p10k.zsh # Powerlevel10k configuration.
source ~/.exa_colors.zsh # Customizes the color scheme of ls and exa.

# source ~/.ghcup/env

typeset -U fpath
fpath+=(
  $HOME/.zsh/
)

typeset -U path
path+=(
  $HOME/.local/bin
  $HOME/bin
  /usr/local/bin
  $HOME/thirdparty/dotty/bin
)
export PATH

typeset -TU PYTHONPATH pythonpath
pythonpath+=(
)
export PYTHONPATH

# Super useful for batch file renames, eg: `zmv '*test*' '$f:gs/csv/tsv'`
# Use -n to dry run.
autoload -U zmv

# Check is zinit is installed.
if [[ ! -d ~/.zinit/bin/ ]]; then
  git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
  source ~/.zinit/bin/zinit.zsh && zinit self-update
fi
source ~/.zinit/bin/zinit.zsh

zinit ice depth'1'
zinit light romkatv/powerlevel10k

# Normal plugins.
zinit light-mode depth'1' for \
  svn OMZ::plugins/ssh-agent \
  svn OMZ::plugins/thefuck \
  rupa/z \
  changyuheng/fz \
  atload'_zsh_autosuggest_start' zsh-users/zsh-autosuggestions \
  MichaelAquilina/zsh-auto-notify

# Completions
zinit light-mode depth'1' blockf atpull'zinit creinstall -q' as'completion' for \
  svn OMZ::plugins/fd \
  svn OMZ::plugins/ripgrep \
  svn OMZ::plugins/docker \
  svn OMZ::plugins/docker-compose

# Completions with other functions.
zinit light-mode depth'1' blockf atpull'zinit creinstall -q' for \
  svn OMZ::plugins/fzf \
  zsh-users/zsh-completions

zinit ice depth'1' atload'
typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='"'""bg=$jblue,fg=$jwhite,bold""'"'
typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='"'""bg=$jlred,fg=$jwhite,bold""'"'
'
zinit light zsh-users/zsh-history-substring-search

zinit ice depth'1' atload'fast-theme XDG:jacob > /dev/null; zicompinit; zicdreplay' nocd
zinit light zdharma/fast-syntax-highlighting

# MichaelAquilina/zsh-auto-notify:
# Don't get notifications for these commands.
AUTO_NOTIFY_IGNORE+=("ipython" "python" "scala" "amm" "bat")

# zsh-users/zsh-history-substring-search:
# Bind up and down keys to history search.
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down

# zsh-users/zsh-autosuggestions:
# Use history to autocomplete, or use completion if there's no history.
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# Async autosuggestions.
export ZSH_AUTOSUGGEST_USE_ASYNC=1

############################
# vv Taken from oh-my-zsh vv
############################
zmodload -i zsh/complist

unsetopt menu_complete # Do not autoselect the first completion entry.
unsetopt flowcontrol # Disabled flow control (idk)
setopt auto_menu # show completion menu on successive tab press
setopt complete_in_word # Completion is done from both ends of a word? I don't fully understand this one.
setopt always_to_end # Move cursor to end of the word on completion.

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'
# ... unless we really want to.
zstyle '*' single-ignored show
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

bindkey '^r' history-incremental-search-backward

if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line # [Home] - Go to beginning of line
fi
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}"  end-of-line # [End] - Go to end of line
fi

bindkey ' ' magic-space # [Space] - do history expansion

bindkey '^[[1;5C' forward-word # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word # [Ctrl-LeftArrow] - move backward one word

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char # [Backspace] - delete backward
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char # [Delete] - delete forward
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

bindkey "^_" copy-prev-shell-word # Ctrl-_ to copy the previous "word" in a command.
############################
# ^^ Taken from oh-my-zsh ^^
############################

setopt auto_pushd # Makes `cd` push to the dir stack.
setopt extended_history # Log timestamp and duration of commands in history.
setopt hist_expire_dups_first # When the history gets too long, expire old duplicates first.
setopt hist_ignore_all_dups # When adding a dupe entry, immediately expire the older duplicate(s).
setopt hist_ignore_space # Don't enter commands that start with a space.
setopt hist_verify # Allow me to edit a line after selecting it from history.
setopt inc_append_history_time # Immediately append commands with time to the history file.
setopt interactive_comments # Allow comments in interactive shell.
setopt long_list_jobs # Print job notifications in the long form.
setopt prompt_subst # Allows expansion and substitution in prompt.
setopt pushd_ignore_dups # Don't add duplicates to the dir stack.
setopt pushd_minus # Swap the meaning of '+' and '-' in pushd.

# Exports
export THIRDPARTY="$HOME/thirdparty"
export WORK="$HOME/work/"
export CFG="$HOME/personal/configurations/"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=10000

# Python version installations:
# /usr/local/Cellar/python/

# Aliases
alias sudo='sudo '
alias thirdparty="cd \$THIRDPARTY"
alias 3p="cd \$THIRDPARTY"
alias work="cd \$WORK"
alias cfg="cd \$CFG"
alias ls="exa -mlha --git --git-ignore --time-style long-iso"
alias gl="git status"
alias reboot="echo nah"
alias rm="trash-put"
alias vi="vim"
alias server="python3 -m http.server"
alias extserver="sudo python3 -m http.server 80"
alias man="batman"

# Functions

# Mute "cd -", I have my pwd in my path, I don't need it again.
cd() {
  if [[ $* =~ "-[0-9]?" ]]; then
    builtin cd "$@" > /dev/null
  else
    builtin cd "$@"
  fi
}

# Fixes commands like "vi vi file".
vim() {
  if [[ $1 = "vi" || $1 = "vim" ]]; then
    command vim "${@:2}"
  else
    command vim "$@"
  fi
}
