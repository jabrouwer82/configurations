source ~/.github_token.sh # Github access token, makes brew/antidote auth easier.
source ~/.work.zsh # for work things that don't belong in github.

# PATH & FPATH Configuration
typeset -Ux fpath
fpath+=(
  "$HOME/.zsh/"
)
typeset -Ux path
path+=(
  "$HOME/.local/bin"
  "$HOME/bin"
  /usr/local/bin
)
case "$OSTYPE" in
  darwin*)
    path=(
      "$HOME/Library/Application\ Support/Coursier/bin"
      "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
      "$HOMEBREW_PREFIX/opt/mysql-client@8.4/bin"
      "$HOMEBREW_PREFIX/opt/mongodb-community@4.4/bin"
      "$PYENV_ROOT/bin"
      "$HOMEBREW_PREFIX/opt/ruby/bin"
      $path
    )
    fpath=(
      "$HOMEBREW_PREFIX/share/zsh/site-functions"
      $fpath
    )
    export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/homebrew/opt/ruby/lib/pkgconfig"
  ;;
  linux*)
    path+=(
      "$HOME/.local/share/coursier/bin"
    )
  ;;
esac

type jenv &> /dev/null && eval "$(jenv init -)"
type pyenv &> /dev/null && eval "$(pyenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

# Some common locations
export THIRDPARTY="$HOME/thirdparty"
export WORK="$HOME/work"
export PERS="$HOME/personal"
export CFG="$PERS/configurations"

# FZF configuration
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Less doesn't do anything if there's less than one page.
export LESS="-FRX $LESS"

export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8
export TERM=xterm-256color
export COLORTERM=truecolor
export PYTHONPATH="${PYTHONPATH}:$HOME/work/python"
export FZF_BASE=/usr/local/bin/fzf
export BAT_STYLE=changes,numbers

# This blocks the 10 second delay on git filter-branch, which is used by my backup script.
# It probably makes more sense to set this only in that script instead.
export FILTER_BRANCH_SQUELCH_WARNING=1

export EDITOR='nvim'
case "$OSTYPE" in
  darwin*)
    export HOMEBREW_NO_AUTO_UPDATE=1
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk
    export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib -L/opt/homebrew/opt/mysql-client/lib -L/opt/homebrew/opt/ruby/lib"
    export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include -I/opt/homebrew/opt/mysql-client/include -I/opt/homebrew/opt/ruby/include"
    export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
    export KUBE_CPUS=6
    export KUBE_MEMORY=16384
    export REPO_USER=jabrouwer82
    export REPO_PASS=DpAsRTwudHSR6UTG
    # source /Users/jbrouwer/.nix-profile/etc/profile.d/nix.sh
  ;;
  linux*)
    export JAVA_HOME='/usr/lib/jvm/default/'
    export RIPGREP_CONFIG_PATH="/home/jbr/.ripgreprc"
    # source /home/jbr/.nix-profile/etc/profile.d/nix.sh
  ;;
esac

# Important: These must use uppercase hex letters for bs to work properly.
export jblack='#00080A'
export jvdgrey='#1F2426'
export jdgrey='#343C41'
export jgrey='#677881'
export jlgrey='#A2BDCB'
export jvlgrey='#C4D1D9'
export jwhite='#E6EEF2'

export jblackblue='#041219'
export jvdblue='#082432'
export jdblue='#0D3C54'
export jblue='#1979A8'
export jlblue='#26B7FF'
export jvlblue='#8CBCD3'

export jblackcyan='#041918'
export jvdcyan='#083230'
export jdcyan='#0D544E'
export jcyan='#19A89C'
export jlcyan='#75CAC3'
export jvlcyan='#BAE4E1'

export jblackgreen='#0D1911'
export jvdgreen='#1A3222'
export jdgreen='#2A5438'
export jgreen='#54A870'
export jlgreen='#7FFFAA'
export jvlgreen='#B0EFC0'

export jblackpurple='#110D19'
export jvdpurple='#221A32'
export jdpurple='#382A54'
export jpurple='#7054A8'
export jlpurple='#AA7FFF'
export jvlpurple='#E5D9FF'

export jblackorange='#190F04'
export jvdorange='#321E08'
export jdorange='#54300D'
export jorange='#A86119'
export jlorange='#FF9326'
export jvlorange='#FFECD9'

export jblackyellow='#191508'
export jvdyellow='#322A10'
export jdyellow='#544519'
export jyellow='#A88B32'
export jlyellow='#FFD24C'
export jvlyellow='#FFF5D9'

export jblackred='#190808'
export jvdred='#321010'
export jdred='#541919'
export jred='#A83232'
export jlred='#FF4C4C'
export jvlred='#C48484'

export jblackmagenta='#190D12'
export jvdmagenta='#321A24'
export jdmagenta='#542A3D'
export jmagenta='#A8547A'
export jlmagenta='#FF7FB9'
export jvlmagenta='#FFD9EA'

function exahex() {
  p1=$(h2d ${1[2,3]})
  p2=$(h2d ${1[4,5]})
  p3=$(h2d ${1[6,7]})
  echo "$p1;$p2;$p3"
}

function rghex() {
  p1=${1[2,3]}
  p2=${1[4,5]}
  p3=${1[6,7]}
  echo "0x$p1,0x$p2,0x$p3"
}

function h2d() {
  echo "obase=10; ibase=16; $1" | bc
}

export jblackexa=$(exahex $jblack)
export jvdgreyexa=$(exahex $jvdgrey)
export jdgreyexa=$(exahex $jdgrey)
export jgreyexa=$(exahex $jgrey)
export jlgreyexa=$(exahex $jlgrey)
export jvlgreyexa=$(exahex $jvlgrey)
export jwhiteexa=$(exahex $jwhite)

export jblackblueexa=$(exahex $jblackblue)
export jvdblueexa=$(exahex $jvdblue)
export jdblueexa=$(exahex $jdblue)
export jblueexa=$(exahex $jblue)
export jlblueexa=$(exahex $jlblue)
export jvlblueexa=$(exahex $jvlblue)

export jblackcyanexa=$(exahex $jblackcyan)
export jvdcyanexa=$(exahex $jvdcyan)
export jdcyanexa=$(exahex $jdcyan)
export jcyanexa=$(exahex $jcyan)
export jlcyanexa=$(exahex $jlcyan)
export jvlcyanexa=$(exahex $jvlcyan)

export jblackgreenexa=$(exahex $jblackgreen)
export jvdgreenexa=$(exahex $jvdgreen)
export jdgreenexa=$(exahex $jdgreen)
export jgreenexa=$(exahex $jgreen)
export jlgreenexa=$(exahex $jlgreen)
export jvlgreenexa=$(exahex $jvlgreen)

export jblackpurpleexa=$(exahex $jblackpurple)
export jvdpurpleexa=$(exahex $jvdpurple)
export jdpurpleexa=$(exahex $jdpurple)
export jpurpleexa=$(exahex $jpurple)
export jlpurpleexa=$(exahex $jlpurple)
export jvlpurpleexa=$(exahex $jvlpurple)

export jblackorangeexa=$(exahex $jblackorange)
export jvdorangeexa=$(exahex $jvdorange)
export jdorangeexa=$(exahex $jdorange)
export jorangeexa=$(exahex $jorange)
export jlorangeexa=$(exahex $jlorange)
export jvlorangeexa=$(exahex $jvlorange)

export jblackyellowexa=$(exahex $jblackyellow)
export jvdyellowexa=$(exahex $jvdyellow)
export jdyellowexa=$(exahex $jdyellow)
export jyellowexa=$(exahex $jyellow)
export jlyellowexa=$(exahex $jlyellow)
export jvlyellowexa=$(exahex $jvlyellow)

export jblackredexa=$(exahex $jblackred)
export jvdredexa=$(exahex $jvdred)
export jdredexa=$(exahex $jdred)
export jredexa=$(exahex $jred)
export jlredexa=$(exahex $jlred)
export jvlredexa=$(exahex $jvlred)

export jblackmagentaexa=$(exahex $jblackmagenta)
export jvdmagentaexa=$(exahex $jvdmagenta)
export jdmagentaexa=$(exahex $jdmagenta)
export jmagentaexa=$(exahex $jmagenta)
export jlmagentaexa=$(exahex $jlmagenta)
export jvlmagentaexa=$(exahex $jvlmagenta)

export jblackrg=$(rghex $jblack)
export jvdgreyrg=$(rghex $jvdgrey)
export jdgreyrg=$(rghex $jdgrey)
export jgreyrg=$(rghex $jgrey)
export jlgreyrg=$(rghex $jlgrey)
export jvlgreyrg=$(rghex $jvlgrey)
export jwhiterg=$(rghex $jwhite)

export jblackbluerg=$(rghex $jblackblue)
export jvdbluerg=$(rghex $jvdblue)
export jdbluerg=$(rghex $jdblue)
export jbluerg=$(rghex $jblue)
export jlbluerg=$(rghex $jlblue)
export jvlbluerg=$(rghex $jvlblue)

export jblackcyanrg=$(rghex $jblackcyan)
export jvdcyanrg=$(rghex $jvdcyan)
export jdcyanrg=$(rghex $jdcyan)
export jcyanrg=$(rghex $jcyan)
export jlcyanrg=$(rghex $jlcyan)
export jvlcyanrg=$(rghex $jvlcyan)

export jblackgreenrg=$(rghex $jblackgreen)
export jvdgreenrg=$(rghex $jvdgreen)
export jdgreenrg=$(rghex $jdgreen)
export jgreenrg=$(rghex $jgreen)
export jlgreenrg=$(rghex $jlgreen)
export jvlgreenrg=$(rghex $jvlgreen)

export jblackpurplerg=$(rghex $jblackpurple)
export jvdpurplerg=$(rghex $jvdpurple)
export jdpurplerg=$(rghex $jdpurple)
export jpurplerg=$(rghex $jpurple)
export jlpurplerg=$(rghex $jlpurple)
export jvlpurplerg=$(rghex $jvlpurple)

export jblackorangerg=$(rghex $jblackorange)
export jvdorangerg=$(rghex $jvdorange)
export jdorangerg=$(rghex $jdorange)
export jorangerg=$(rghex $jorange)
export jlorangerg=$(rghex $jlorange)
export jvlorangerg=$(rghex $jvlorange)

export jblackyellowrg=$(rghex $jblackyellow)
export jvdyellowrg=$(rghex $jvdyellow)
export jdyellowrg=$(rghex $jdyellow)
export jyellowrg=$(rghex $jyellow)
export jlyellowrg=$(rghex $jlyellow)
export jvlyellowrg=$(rghex $jvlyellow)

export jblackredrg=$(rghex $jblackred)
export jvdredrg=$(rghex $jvdred)
export jdredrg=$(rghex $jdred)
export jredrg=$(rghex $jred)
export jlredrg=$(rghex $jlred)
export jvlredrg=$(rghex $jvlred)

export jblackmagentarg=$(rghex $jblackmagenta)
export jvdmagentarg=$(rghex $jvdmagenta)
export jdmagentarg=$(rghex $jdmagenta)
export jmagentarg=$(rghex $jmagenta)
export jlmagentarg=$(rghex $jlmagenta)
export jvlmagentarg=$(rghex $jvlmagenta)

# Can't use variables in .ripgreprc, so this has to be an alias.
alias rg="rg --colors=line:fg:$jlbluerg --colors=line:style:nobold --colors=path:fg:$jlpurplerg --colors=path:style:nobold --colors=match:fg:$jblackrg --colors=match:bg:$jlyellowrg --colors=match:style:nobold"
