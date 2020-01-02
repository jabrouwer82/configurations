export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Set a root location for undo/back/swp files.
export VIM_TMP_DIR=$HOME'/.tmp/vim'

# Less doesn't do anything if there's less than one page.
export LESS="-FRX $LESS"

export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8
export EDITOR='vim'
export TERM=xterm-256color
export PYTHONPATH="${PYTHONPATH}:$HOME/work/python"
export FZF_BASE=/usr/local/bin/fzf


case "$OSTYPE" in
  darwin*)
    export HOMEBREW_NO_AUTO_UPDATE=1
    export JAVA_HOME='/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home'
    export RIPGREP_CONFIG_PATH="/Users/jbrouwer/.ripgreprc"
  ;;
  linux*)
    export JAVA_HOME='/usr/lib/jvm/default/'
    export RIPGREP_CONFIG_PATH="/home/jbr/.ripgreprc"
  ;;
esac

# Important: These must use uppercase hex letters for bs to work properly.
export jblack="#00080A"
export jwhite="#E4FDFD"

export jdgrey="#252A2D"
export jgrey="#6B7A82"
export jlgrey="#B1CBD7"

export jdblue="#0D3D55"
export jblue="#1A7DAA"
export jlblue="#28B8FF"

export jdcyan="#165550"
export jcyan="#2CAAA0"
export jlcyan="#42FFF0"

export jdgreen="#2D553A"
export jgreen="#5AAA75"
export jlgreen="#87FFAF"

export jdpurple="#392C55"
export jpurple="#7358AA"
export jlpurple="#AD84FF"

export jdorange="#552F0F"
export jorange="#AA5E1F"
export jlorange="#FF8D2F"

export jdyellow="#55461A"
export jyellow="#AA8D34"
export jlyellow="#FFD54F"

export jvdred="#280400"
export jdred="#551A1A"
export jred="#AA3535"
export jlred="#FF5050"

export jdmagenta="#552A3D"
export jmagenta="#AA557B"
export jlmagenta="#FF80B9"

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
export jwhiteexa=$(exahex $jwhite)

export jdgreyexa=$(exahex $jdgrey)
export jgreyexa=$(exahex $jgrey)
export jlgreyexa=$(exahex $jlgrey)

export jdblueexa=$(exahex $jdblue)
export jblueexa=$(exahex $jblue)
export jlblueexa=$(exahex $jlblue)

export jdcyanexa=$(exahex $jdcyan)
export jcyanexa=$(exahex $jcyan)
export jlcyanexa=$(exahex $jlcyan)

export jdgreenexa=$(exahex $jdgreen)
export jgreenexa=$(exahex $jgreen)
export jlgreenexa=$(exahex $jlgreen)

export jdpurpleexa=$(exahex $jdpurple)
export jpurpleexa=$(exahex $jpurple)
export jlpurpleexa=$(exahex $jlpurple)

export jdorangeexa=$(exahex $jdorange)
export jorangeexa=$(exahex $jorange)
export jlorangeexa=$(exahex $jlorange)

export jdyellowexa=$(exahex $jdyellow)
export jyellowexa=$(exahex $jyellow)
export jlyellowexa=$(exahex $jlyellow)

export jvdredexa=$(exahex $jvdred)
export jdredexa=$(exahex $jdred)
export jredexa=$(exahex $jred)
export jlredexa=$(exahex $jlred)

export jdmagentaexa=$(exahex $jdmagenta)
export jmagentaexa=$(exahex $jmagenta)
export jlmagentaexa=$(exahex $jlmagenta)

export jblackrg=$(rghex $jblack)
export jwhiterg=$(rghex $jwhite)

export jdgreyrg=$(rghex $jdgrey)
export jgreyrg=$(rghex $jgrey)
export jlgreyrg=$(rghex $jlgrey)

export jdbluerg=$(rghex $jdblue)
export jbluerg=$(rghex $jblue)
export jlbluerg=$(rghex $jlblue)

export jdcyanrg=$(rghex $jdcyan)
export jcyanrg=$(rghex $jcyan)
export jlcyanrg=$(rghex $jlcyan)

export jdgreenrg=$(rghex $jdgreen)
export jgreenrg=$(rghex $jgreen)
export jlgreenrg=$(rghex $jlgreen)

export jdpurplerg=$(rghex $jdpurple)
export jpurplerg=$(rghex $jpurple)
export jlpurplerg=$(rghex $jlpurple)

export jdorangerg=$(rghex $jdorange)
export jorangerg=$(rghex $jorange)
export jlorangerg=$(rghex $jlorange)

export jdyellowrg=$(rghex $jdyellow)
export jyellowrg=$(rghex $jyellow)
export jlyellowrg=$(rghex $jlyellow)

export jvdredrg=$(rghex $jvdred)
export jdredrg=$(rghex $jdred)
export jredrg=$(rghex $jred)
export jlredrg=$(rghex $jlred)

export jdmagentarg=$(rghex $jdmagenta)
export jmagentarg=$(rghex $jmagenta)
export jlmagentarg=$(rghex $jlmagenta)

# Can't use variables in .ripgreprc, so this has to be an alias.
alias rg="rg --colors=line:fg:$jlbluerg --colors=line:style:nobold --colors=path:fg:$jlpurplerg --colors=path:style:nobold --colors=match:fg:$jblackrg --colors=match:bg:$jlyellowrg --colors=match:style:nobold"
