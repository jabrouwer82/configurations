
# FZF configuration
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Less doesn't do anything if there's less than one page.
export LESS="-FRX $LESS"

export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8
export EDITOR='vim'
export TERM=xterm-256color
export PYTHONPATH="${PYTHONPATH}:$HOME/work/python"
export FZF_BASE=/usr/local/bin/fzf

# This blocks the 10 second delay on git filter-branch, which is used by my backup script.
# It probably makes more sense to set this only in that script instead.
export FILTER_BRANCH_SQUELCH_WARNING=1

case "$OSTYPE" in
  darwin*)
    export HOMEBREW_NO_AUTO_UPDATE=1
    export JAVA_HOME='/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home'
    export RIPGREP_CONFIG_PATH="/Users/jbrouwer/.ripgreprc"
    source /Users/jbrouwer/.nix-profile/etc/profile.d/nix.sh
  ;;
  linux*)
    export JAVA_HOME='/usr/lib/jvm/default/'
    export RIPGREP_CONFIG_PATH="/home/jbr/.ripgreprc"
    source /home/jbr/.nix-profile/etc/profile.d/nix.sh
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

export jvdblue='#041219'
export jdblue='#0D3C54'
export jblue='#1979A8'
export jlblue='#26B7FF'
export jvlblue='#D9F2FF'

export jvdcyan='#041918'
export jdcyan='#0D544E'
export jcyan='#19A89C'
export jlcyan='#26FFED'
export jvlcyan='#D9FFFC'

export jvdgreen='#0D1911'
export jdgreen='#2A5438'
export jgreen='#54A870'
export jlgreen='#7FFFAA'
export jvlgreen='#D9FFE5'

export jvdpurple='#110D19'
export jdpurple='#382A54'
export jpurple='#7054A8'
export jlpurple='#AA7FFF'
export jvlpurple='#E5D9FF'

export jvdorange='#190F04'
export jdorange='#54300D'
export jorange='#A86119'
export jlorange='#FF9326'
export jvlorange='#FFECD9'

export jvdyellow='#191508'
export jdyellow='#544519'
export jyellow='#A88B32'
export jlyellow='#FFD24C'
export jvlyellow='#FFF5D9'

export jvdred='#190808'
export jdred='#541919'
export jred='#A83232'
export jlred='#FF4C4C'
export jvlred='#FFD9D9'

export jvdmagenta='#190D12'
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

export jvdblueexa=$(exahex $jvdblue)
export jdblueexa=$(exahex $jdblue)
export jblueexa=$(exahex $jblue)
export jlblueexa=$(exahex $jlblue)
export jvlblueexa=$(exahex $jvlblue)

export jvdcyanexa=$(exahex $jvdcyan)
export jdcyanexa=$(exahex $jdcyan)
export jcyanexa=$(exahex $jcyan)
export jlcyanexa=$(exahex $jlcyan)
export jvlcyanexa=$(exahex $jvlcyan)

export jvdgreenexa=$(exahex $jvdgreen)
export jdgreenexa=$(exahex $jdgreen)
export jgreenexa=$(exahex $jgreen)
export jlgreenexa=$(exahex $jlgreen)
export jvlgreenexa=$(exahex $jvlgreen)

export jvdpurpleexa=$(exahex $jvdpurple)
export jdpurpleexa=$(exahex $jdpurple)
export jpurpleexa=$(exahex $jpurple)
export jlpurpleexa=$(exahex $jlpurple)
export jvlpurpleexa=$(exahex $jvlpurple)

export jvdorangeexa=$(exahex $jvdorange)
export jdorangeexa=$(exahex $jdorange)
export jorangeexa=$(exahex $jorange)
export jlorangeexa=$(exahex $jlorange)
export jvlorangeexa=$(exahex $jvlorange)

export jvdyellowexa=$(exahex $jvdyellow)
export jdyellowexa=$(exahex $jdyellow)
export jyellowexa=$(exahex $jyellow)
export jlyellowexa=$(exahex $jlyellow)
export jvlyellowexa=$(exahex $jvlyellow)

export jvdredexa=$(exahex $jvdred)
export jvdredexa=$(exahex $jvdred)
export jdredexa=$(exahex $jdred)
export jredexa=$(exahex $jred)
export jlredexa=$(exahex $jlred)
export jvlredexa=$(exahex $jvlred)

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

export jvdbluerg=$(rghex $jvdblue)
export jdbluerg=$(rghex $jdblue)
export jbluerg=$(rghex $jblue)
export jlbluerg=$(rghex $jlblue)
export jvlbluerg=$(rghex $jvlblue)

export jvdcyanrg=$(rghex $jvdcyan)
export jdcyanrg=$(rghex $jdcyan)
export jcyanrg=$(rghex $jcyan)
export jlcyanrg=$(rghex $jlcyan)
export jvlcyanrg=$(rghex $jvlcyan)

export jvdgreenrg=$(rghex $jvdgreen)
export jdgreenrg=$(rghex $jdgreen)
export jgreenrg=$(rghex $jgreen)
export jlgreenrg=$(rghex $jlgreen)
export jvlgreenrg=$(rghex $jvlgreen)

export jvdpurplerg=$(rghex $jvdpurple)
export jdpurplerg=$(rghex $jdpurple)
export jpurplerg=$(rghex $jpurple)
export jlpurplerg=$(rghex $jlpurple)
export jvlpurplerg=$(rghex $jvlpurple)

export jvdorangerg=$(rghex $jvdorange)
export jdorangerg=$(rghex $jdorange)
export jorangerg=$(rghex $jorange)
export jlorangerg=$(rghex $jlorange)
export jvlorangerg=$(rghex $jvlorange)

export jvdyellowrg=$(rghex $jvdyellow)
export jdyellowrg=$(rghex $jdyellow)
export jyellowrg=$(rghex $jyellow)
export jlyellowrg=$(rghex $jlyellow)
export jvlyellowrg=$(rghex $jvlyellow)

export jvdredrg=$(rghex $jvdred)
export jvdredrg=$(rghex $jvdred)
export jdredrg=$(rghex $jdred)
export jredrg=$(rghex $jred)
export jlredrg=$(rghex $jlred)
export jvlredrg=$(rghex $jvlred)

export jvdmagentarg=$(rghex $jvdmagenta)
export jdmagentarg=$(rghex $jdmagenta)
export jmagentarg=$(rghex $jmagenta)
export jlmagentarg=$(rghex $jlmagenta)
export jvlmagentarg=$(rghex $jvlmagenta)

# Can't use variables in .ripgreprc, so this has to be an alias.
alias rg="rg --colors=line:fg:$jlbluerg --colors=line:style:nobold --colors=path:fg:$jlpurplerg --colors=path:style:nobold --colors=match:fg:$jblackrg --colors=match:bg:$jlyellowrg --colors=match:style:nobold"
