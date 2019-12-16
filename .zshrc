source ~/.exa_colors.zsh # Customizes the color scheme of ls and exa.

source /Users/jbrouwer/.ghcup/env

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
  $HOME/.cargo/bin
  $HOME/.gcloud/bin
)
export PATH

# Check is zplugin is installed.
if [[ ! -d ~/.zplugin/bin/ ]]; then
  git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
  source ~/.zplugin/bin/zplugin.zsh && zplugin self-update
fi
source ~/.zplugin/bin/zplugin.zsh

zplugin ice wait'!0a' depth'1' atload'!source ~/.p10k.zsh; _p9k_precmd'
zplugin load romkatv/powerlevel10k

# Completions
zplugin wait'0b' depth'1' blockf atpull'zplugin creinstall -q' as'completion' lucid for \
  svn OMZ::plugins/cargo \
  svn OMZ::plugins/fd \
  svn OMZ::plugins/ripgrep

# Completions with other functions.
zplugin wait'0b' depth'1' blockf atpull'zplugin creinstall -q' lucid for \
  svn OMZ::plugins/cabal \
  svn OMZ::plugins/fzf \
  svn OMZ::plugins/kubectl \
  zsh-users/zsh-completions \
  littleq0903/gcloud-zsh-completion

# Normal plugins.
zplugin wait'0a' depth'1' lucid for \
  svn OMZ::plugins/ssh-agent \
  svn OMZ::plugins/thefuck \
  rupa/z \
  changyuheng/fz \
  atload'_zsh_autosuggest_start' zsh-users/zsh-autosuggestions \
  MichaelAquilina/zsh-auto-notify \
  b4b4r07/emoji-cli \
  zsh-users/zsh-history-substring-search

zplugin ice lucid wait'0c' depth'1' atinit"zpcompinit; zpcdreplay"
zplugin load zdharma/fast-syntax-highlighting

# MichaelAquilina/zsh-auto-notify:
# Don't get notifications for these commands.
AUTO_NOTIFY_IGNORE+=("ipython" "python" "scala" "amm" "bat")

# zsh-users/zsh-history-substring-search:
# Bind up and down keys to history search.
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down
typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=#0087AF,fg=white,bold'
typeset -g HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=#EF2929,fg=white,bold'

# zsh-users/zsh-autosuggestions:
# Use history to autocomplete, or use completion if there's no history.
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# Async autosuggestions.
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# zsh-users/zsh-syntax-highlighting:
# Just highlight fucking everything.
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)

# vv Taken from oh-my-zsh vv
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

bindkey -e # Use emacs key bindings

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
# ^^ Taken from oh-my-zsh ^^

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
# Less doesn't do anything if there's less than one page.
export LESS="-F -X $LESS"
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR='vim'
export TERM=xterm-256color
export HOMEBREW_NO_AUTO_UPDATE=1
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"
export PYTHONPATH="${PYTHONPATH}:$HOME/work/python"
export RIPGREP_CONFIG_PATH="/Users/jbrouwer/.ripgreprc"
export FZF_BASE=/usr/local/bin/fzf
export THIRDPARTY="$HOME/thirdparty"
export WORK="$HOME/work/"
export SCF="$HOME/work/foundation"
export CFG="$HOME/personal/configurations/"
export CLOUDSDK_CORE_PROJECT='sparkcognition-dev'
# Use ripgrep for fzf to respect gitignore files.
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=50000
export SAVEHIST=10000

# Aliases
alias sudo='sudo '
alias thirdparty="cd \$THIRDPARTY"
alias 3p="cd \$THIRDPARTY"
alias work="cd \$WORK"
alias scf="cd \$SCF"
alias cfg="cd \$CFG"
alias scala="amm"
alias python="ipython"
alias ipyinstall="cd ~/work/test/ipython && pip install -e"
#alias ls="ls -AlFhG"
alias ls="exa -mlha --git --git-ignore --time-style long-iso"
alias gl="git status"
alias rgsc="rg -tscala"
alias rgpy="rg -tpy"
alias rgts="rg -tts"
alias rgjs="rg -tjs"
alias reboot="echo nap"
alias rm="trash-put"
alias vi="vim"
alias server="python3 -m http.server"
alias extserver="sudo python3 -m http.server 80"
alias pip3="sudo pip3"
alias man="~/thirdparty/bat-extras/src/batman.sh"

# Functions

# Setup for docker compose nonsense.
hostip() {
  echo $(ifconfig en0 | awk '$1 == "inet" {print $2}')
}

sethostip() {
  export HOST_IP=$(hostip)
}

precmd_functions+=( sethostip )

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

# unalias tmux
# tmux() {
#   if [[ -z $* ]]; then
#     command tmux a 2&> /dev/null || command tmux
#   else
#     command tmux $*
#   fi
# }

# Detaches tmux if closing the last pane in the open session, else just calls exit.
# exit() {
#   if [[ -z $TMUX ]] || [[ $(tmux list-panes -s | wc -l) -gt 1 ]]; then
#     builtin exit
#   else
#     tmux detach
#   fi
# }
