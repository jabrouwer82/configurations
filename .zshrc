source ~/.p10k.zsh # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source ~/.exa_colors.zsh # Customizes the color scheme of ls and exa.

source /Users/jbrouwer/.gcloud/path.zsh.inc
source /Users/jbrouwer/.gcloud/completion.zsh.inc

fpath=(/Users/jbrouwer/.zsh/ $fpath)

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/thirdparty/dotty/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

export ZSH="/Users/jbrouwer/.oh-my-zsh"

export ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_THEME="powerlevel10k/powerlevel10k"
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

plugins=(
  fd
  git
  fzf
  scala
  sbt
  ripgrep
  colorize
  colored-man-pages
  command-not-found
  thefuck
  ssh-agent
  tmux
  kubectl
  zsh-completions
)

DISABLE_MAGIC_FUNCTIONS=true
source $ZSH/oh-my-zsh.sh

setopt autopushd
setopt pushdignoredups

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
export HOST_IP=$(ifconfig en0 | awk '$1 == "inet" {print $2}')
# Use ripgrep for fzf to respect gitignore files.
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


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

unalias tmux
tmux() {
  if [[ -z $* ]]; then
    command tmux a 2&> /dev/null || command tmux
  else
    command tmux $*
  fi
}

# Detaches tmux if closing the last pane in the open session, else just calls exit.
exit() {
  if [[ -z $TMUX ]] || [[ $(tmux list-panes -s | wc -l) -gt 1 ]]; then
    builtin exit
  else
    tmux detach
  fi
}

autoload -Uz bashcompinit
bashcompinit

autoload -Uz compinit
compinit
