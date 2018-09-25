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

complete -W "k2247 k5034 k800004 k800009 k800011 k800016" ./docker-push.sh
complete -W "k2 testk2 portal wiki 2247 k10442 k5034 k800004 k800009 k800011 k800016" ssh
complete -W "k2 testk2 portal wiki 2247 k10442 k5034 k800004 k800009 k800011 k800016" scp
. <(gr completion)

export TERM=xterm-256color

eval $(thefuck --alias)

export KILI="/home/jabrouwer/work/work/kilimanjaro"

function vagrant {
  cd $KILI
  if [[ $@ == "restart" ]]; then
    command vagrant destroy -f && vagrant up
  else
    command vagrant "$@"
  fi
}

function runkili {
  if [[ -z "$(docker ps -f "status=running" | grep kili)" ]]; then
    cd $KILI
    vagrant up
  elif [[ $@ ]]; then
    cd $KILI
    vagrant restart
  fi

  docker exec -it -u vagrant -w /home/vagrant/kilimanjaro kili /bin/bash /home/vagrant/bin/sbt run
}

function abbrev_pwd {
  echo "${PWD#~/work/}"
}

function recover_text {
  # This probably doesn't quite work.
  local OPTIND o a
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

  sudo grep -a -C 200 -F $search $(df -P . | tail -1 | cut -d' ' -f 1) > $file
}

function nord {
  sudo openvpn --config $(\ls /etc/openvpn/ovpn_udp/us* | shuf -n 1) --auth-user-pass /etc/openvpn/nordvpn.txt
}

PS1='\[\e[1;90m\]┌[\[\e[1;34m\]$(abbrev_pwd)\[\e[1;90m\]:\[\e[1;33m\]$(git current)\[\e[1;90m\]]:\n\[\e[1;90m\]└[\[\e[1;35m\]\A\[\e[1;90m\]]\[\e[0m\]\$ '
export PYTHONPATH="${PYTHONPATH}:/home/jabrouwer/work/work/python"

alias sudo='sudo '

alias kili="cd $KILI"

alias vi="vim"
alias k2="ssh k2"
alias testk2="ssh testk2"
alias portal="ssh portal"
alias wiki="ssh wiki"
export KIOSK_NUMBER=1882
#alias vpn="sudo openvpn --config /etc/openvpn/openvpn.conf --askpass /etc/openvpn/key.txt"
export RECOVER="sudo grep -a -C 200 -F 'thing to search for' /dev/nvme0n1p4 > test.txt"

alias scala="amm"
alias python="ipython"
alias ipyinstall="cd ~/work/test/ipython && pip install -e"
alias ls="ls -AlFh --color=always"
alias rg="rg --colors line:fg:yellow --colors line:style:bold --colors path:fg:green --colors path:style:bold --colors match:fg:black --colors match:bg:yellow --colors match:style:nobold -S"
alias reboot="echo nah"
alias rm="trash-put"

alias gpasswd="sudo gpasswd"
alias pacrepo="sudo reflector -l 20 -f 10 --save /etc/pacman.d/mirrorlist"
alias pacman="sudo pacman"
alias pip3="sudo pip3"
alias yaourt="yaourt --noconfirm"
alias journalctl="sudo journalctl"
alias pacu="sudo pacman -Syu --noconfirm"
alias auru="yaourt -Syua --noconfirm"
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