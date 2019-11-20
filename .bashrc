#! /bin/bash

if [[ -f ~/.extend.bashrc ]]; then . ~/.extend.bashrc; fi
if [[ -f ~/.git-competion.bash ]]; then . ~/.git-completion.bash; fi

if [[ -f /usr/share/fzf/completion.bash ]]; then . /usr/share/fzf/completion.bash; fi
if [[ -f /usr/share/fzf/key-bindings.bash ]]; then . /usr/share/fzf/key-bindings.bash; fi

if [[ -r /usr/share/bash-completion/bash_completion ]]; then . /usr/share/bash-completion/bash_completion; fi
if [[ -r ~/.docker-push-completion.bash ]]; then . ~/.docker-push-completion.bash; fi

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
export HISTCONTROL=ignoredups

export HISTTIMEFORMAT="%F %T: "

#complete -C "ls \"$DEMO\"/" demo
complete -W "k2247 k5034 k800004 k800009 k800011 k800016" ./docker-push.sh
complete -W "k2 testk2 portal wiki 2247 k10442 k5034 k800004 k800009 k800011 k800016" ssh
complete -W "k2 testk2 portal wiki 2247 k10442 k5034 k800004 k800009 k800011 k800016" scp
_kili_complete() {
  local cur prev

  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  prev=${COMP_WORDS[COMP_CWORD-1]}

  if [ $COMP_CWORD -eq 1 ]; then
    COMPREPLY=( $(compgen -W "cheyenne/run robot/run clean push reset-error restart run test:compile update" -- "$cur") )
  elif [ $COMP_CWORD -eq 2 ]; then
    case "$prev" in
      "push")
        COMPREPLY=( $(compgen -W "k2247 k5034 k800004 k800009 k800011 k800016" -- "$cur") )
        ;;
      *)
        ;;
    esac
  fi

  return 0
} && complete -F _kili_complete kili

# # Git multirepo
# source <(gr completion)

export TERM=xterm-256color
export HOMEBREW_NO_AUTO_UPDATE=1

eval "$(thefuck --alias)"

export KILI="/home/jabrouwer/work/work/mammoth/kilimanjaro"
export COMMON="/home/jabrouwer/work/work/mammoth/common"
export K2="/home/jabrouwer/work/work/mammoth/k2"
export DEMO="/home/jabrouwer/work/demo"
export THIRDPARTY="/home/jabrouwer/work/thirdparty"
#export SCALA_HOME="/usr/share/scala"
#export JAVA_HOME="/usr/lib/jvm/java-8-openjdk/jre"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"

vagrant() {
  cd $KILI || return
  if [[ $* == "restart" ]]; then
    command vagrant destroy -f && vagrant up
  elif [[ $* == "ssh" ]]; then
    # Something is rotten in the state of my vagrant setup.
    docker exec -it -u vagrant -w /home/vagrant/kilimanjaro kili /bin/bash
  else
    command vagrant "$@"
  fi
  cd - || return
}

kili() {
  if [[ -z $* ]]; then
    cd $KILI || return
    return 0
  elif [[ $1 = "push" ]]; then
    # echo "Cleaning sbt"
    # sbt clean
    cd $KILI/scripts || return
    kili reset-error $2
    cd $KILI/scripts || return
    echo "Pushing to $2"
    ./docker-push.sh "$2"
    cd - || return
    return 0
  fi

  if [[ $1 = "restart" ]]; then
    vagrant restart
  elif ! docker ps -a -f "status=running" | grep -q kili ; then
    vagrant restart
  fi

  if [[ $1 = "restart" ]]; then
    cmd=$2
  else
    cmd=$1
  fi

  if [[ $1 = "clean" ]]; then
    sbt clean
  fi

  if [[ $cmd = "ssh" ]]; then
    docker exec -it -u vagrant -w /home/vagrant/kilimanjaro kili /bin/bash
  elif [[ $cmd = "reset-error" ]]; then
    if [[ $# -gt 1 ]]; then
      echo "Reseting error on $2"
      ssh "$2" "sudo reset-error"
    else
      echo "Reseting error on local kiosk"
      docker exec -it -u vagrant -w /home/vagrant/kilimanjaro kili sudo reset-error
    fi
  elif [[ $cmd = "update" ]]; then
    docker exec -it -u vagrant -w /home/vagrant/kilimanjaro kili sudo zypper in -y kili-resources
  else
    docker exec -it -u vagrant -w /home/vagrant/kilimanjaro kili /bin/bash /home/vagrant/bin/sbt "$cmd"
  fi
}

common() {
  if [[ -z $* ]]; then
    cd $COMMON || return
    return $?
  elif [[ $1 = "update" ]]; then
    cd $COMMON/scripts || return
    ./update-version.sh
    exitval=$?
    cd - || return
    return $exitval
  elif [[ $1 = "local" ]]; then
    cd $COMMON || return
    sbt publish-local
    exitval=$?
    cd - || return
    return $exitval
  elif [[ $1 = "publish" ]]; then
    cd $COMMON || return
    common update && sbt publish
    exitval=$?
    cd - || return
  fi
}

k2() {
  if [[ -z $* ]]; then
    cd $K2 || return
  elif [[ $1 = "ssh" ]]; then
    ssh "k2"
  fi
}

demo() {
  cd $DEMO || return
  if [[ -n $1 ]]; then
    cd "$1" || return
    ls
  fi
}

pathogen() {
  cd /home/jabrouwer/.vim/bundle || return
  git clone "$1"
  cd - || return
}

abbrev_pwd() {
  echo "${PWD#~/work/}"
}

recover_text() {
  # This probably doesn't quite work.
  local OPTIND o
  file="recovered.txt"
  search=""
  while getopts ":o:s:" o; do
    case ${o} in
      o) file=${OPTARG} ;;
      s) search=${OPTARG} ;;
     \?) echo "Invalid option: -$OPTARG" >&2 && return 1 ;;
    esac
  done
  shift $((OPTIND-1))

  if [[ -z $search ]]; then
    echo "You must provide a -s search term"
    return 1
  fi

  sudo grep -a -C 200 -F "$search" "$(df -P . | tail -1 | cut -d' ' -f 1)" | sudo tee "$file"
}

nord() {
  sudo openvpn --config "$(find /etc/openvpn/ovpn_udp/ -name "us*" | shuf -n 1)" --auth-user-pass /etc/openvpn/nordvpn.txt
}

cd() {
  if [[ $* = "-" ]]; then
    command cd - > /dev/null
  else
    command cd "$@"
  fi
}

vim() {
  if [[ $1 = "vi" || $1 = "vim" ]]; then
    command vim "${@:2}"
  else
    command vim "$@"
  fi
}

PS1='\[\e[1;90m\]┌[\[\e[1;34m\]$(abbrev_pwd)\[\e[1;90m\]:\[\e[1;33m\]$(git currentname)\[\e[1;90m\]]\n\[\e[1;90m\]└[\[\e[1;35m\]\t\[\e[1;90m\]]\[\e[0m\]\$ '
export PYTHONPATH="${PYTHONPATH}:/home/jabrouwer/work/work/python"

# Use ripgrep for fzf to respect gitignores
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# GTK3 highdpi scaling
# Scales UI components
export GDK_SCALE=2
# Unscales text
export GDK_DPI_SCALE=0.5

export RIPGREP_CONFIG_PATH="/Users/jbrouwer/.ripgreprc"

alias sudo='sudo '

alias msr605='~/work/thirdparty/msrtool/msrtool.py /dev/msr605'
alias thirdparty="cd \$THIRDPARTY"
alias testk2="ssh testk2"
alias portal="ssh portal"
alias wiki="ssh wiki"
export KIOSK_NUMBER=1882
#alias vpn="sudo openvpn --config /etc/openvpn/openvpn.conf --askpass /etc/openvpn/key.txt"
export RECOVER="sudo grep -a -C 200 -F 'thing to search for' /dev/nvme0n1p4 > test.txt"

alias scala="amm"
alias python="ipython"
alias ipyinstall="cd ~/work/test/ipython && pip install -e"
alias ls="ls -AlFhG"
alias rgsc="rg -tscala"
alias rgpy="rg -tpy"
alias rgts="rg -tts"
alias rgjs="rg -tjs"
alias reboot="echo nap"
alias rm="trash-put"
alias vi="vim"
alias server="python3 -m http.server"
alias extserver="sudo python3 -m http.server 80"

alias scalawatch="fswatch -o ./scalastyle.xml | xargs -n1 -I{} scalastyle -c scalastyle.xml . -x \$(cat duds.txt)"

alias gpasswd="sudo gpasswd"
alias pacrepo="sudo reflector -l 20 -f 10 --save /etc/pacman.d/mirrorlist"
alias pacman="sudo pacman"
alias pip3="sudo pip3"
# alias yaourt="yaourt --noconfirm"
alias journalctl="sudo journalctl"
alias pacu="sudo pacman -Syu --noconfirm"
alias auru="yay -Syu"
alias updateall="auru && npm update -g"
alias systemctl="sudo systemctl"
alias se="ls /usr/bin | grep"

export EDITOR=vim
export QT_STYLE_OVERRIDE=gtk
export QT_SELECT=qt5
#export http_proxy="http://localhost:8118"

if [[ $LANG = "" ]]; then
  export LANG=en_US.UTF-8
fi

export HISTCONTROL=ignoreboth:erasedups

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
