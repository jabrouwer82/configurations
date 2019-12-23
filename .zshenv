export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Set a root location for undo/back/swp files.
export VIM_TMP_DIR=$HOME . '/.tmp/vim'

# Less doesn't do anything if there's less than one page.
export LESS="-FRX $LESS"

export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8
export EDITOR='vim'
export TERM=xterm-256color
export PYTHONPATH="${PYTHONPATH}:$HOME/work/python"
export RIPGREP_CONFIG_PATH="/Users/jbrouwer/.ripgreprc"
export FZF_BASE=/usr/local/bin/fzf


case "$OSTYPE" in
  darwin*)
    export HOMEBREW_NO_AUTO_UPDATE=1
    export JAVA_HOME='/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home'
  ;;
  linux*)
    export JAVA_HOME='/usr/lib/jvm/default/'
  ;;
esac

# Use java 8

export jblack="#00080A"
export jwhite="#E4FDFD"

export jdgrey="#252A2d"
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
