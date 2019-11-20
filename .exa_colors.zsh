FG='38;2;'
BG='48;2;'
BOLD=';1'
UNDER=';4'
WHITE='255;255;255'
LGREY='168;168;168'
GREY='120;120;120'
DGREY='85;85;85'
DPURPLE='90;60;149'
PURPLE='125;95;184'
LPURPLE='160;130;209'
DBLUE='0;100;140'
BLUE='0;135;175'
LBLUE='95;215;255'
DGREEN='40;140;40'
GREEN='76;178;76'
LGREEN='135;255;175'
RED='239;29;41'
ORED='200;80;80'
ORANGE='218;116;0'
YELLOW='252;213;79'

GITADD=$GREEN
GITCHANGE='95;215;255'
GITDELETE='200;80;80'

TODO=$FG$WHITE';'$BG$RED
CHECK=$FG$RED';'$BG$WHITE
CODE=$FG$LBLUE
CONFIG=$FG$PURPLE
OTHER=$FG$DBLUE
DATA=$FG$DGREEN

RAW_LS_COLORS=(
  'no='$TODO # Default.
  'rs='$TODO # Reset.

  'di='$FG$LGREEN # Directories.
  'ex='$FG$ORANGE # Executable Files.
  'fi='$FG$LGREY # Normal file.
  'ln='$FG$WHITE # Symlinks.
  'mh='$FG$WHITE # Regular files with more than one line.
  'mi='$UNDER$FG$RED$UNDER # Non-existent file pointed to by a symbolic link.
  'or='$FG$RED # Symlinks with no target.
  'pi='$FG$ORANGE # Named Pipes.

  'ow='$TODO # Directory that is other-writable (o+w)
  'do='$TODO # Door.
  'bd='$TODO # Block Devices.
  'ca='$TODO # File with capability.
  'cd='$TODO # Character Devices.
  'sg='$TODO # File that is setgid (g+s)
  'so='$TODO # Sockets.
  'st='$TODO # Directory that is sticky (+t)
  'su='$TODO # File that is setuid (u+s)
  'tw='$TODO # Directory that is sticky and other-writable (+t, o+w)

  # Archives
  '*.tar='$OTHER
  '*.tgz='$OTHER
  '*.arc='$OTHER
  '*.arj='$OTHER
  '*.taz='$OTHER
  '*.lha='$OTHER
  '*.lz4='$OTHER
  '*.lzh='$OTHER
  '*.lzma='$OTHER
  '*.tlz='$OTHER
  '*.txz='$OTHER
  '*.tzo='$OTHER
  '*.t7z='$OTHER
  '*.zip='$OTHER
  '*.z='$OTHER
  '*.dz='$OTHER
  '*.gz='$OTHER
  '*.lrz='$OTHER
  '*.lz='$OTHER
  '*.lzo='$OTHER
  '*.xz='$OTHER
  '*.zst='$OTHER
  '*.tzst='$OTHER
  '*.bz2='$OTHER
  '*.bz='$OTHER
  '*.tbz='$OTHER
  '*.tbz2='$OTHER
  '*.tz='$OTHER
  '*.deb='$OTHER
  '*.rpm='$OTHER
  '*.jar='$OTHER
  '*.war='$OTHER
  '*.ear='$OTHER
  '*.sar='$OTHER
  '*.rar='$OTHER
  '*.alz='$OTHER
  '*.ace='$OTHER
  '*.zoo='$OTHER
  '*.cpio='$OTHER
  '*.7z='$OTHER
  '*.rz='$OTHER
  '*.cab='$OTHER
  '*.wim='$OTHER
  '*.swm='$OTHER
  '*.dwm='$OTHER
  '*.esd='$OTHER

  # Visual media
  '*.jpg='$OTHER
  '*.jpeg='$OTHER
  '*.mjpg='$OTHER
  '*.mjpeg='$OTHER
  '*.gif='$OTHER
  '*.bmp='$OTHER
  '*.pbm='$OTHER
  '*.pgm='$OTHER
  '*.ppm='$OTHER
  '*.tga='$OTHER
  '*.xbm='$OTHER
  '*.xpm='$OTHER
  '*.tif='$OTHER
  '*.tiff='$OTHER
  '*.png='$OTHER
  '*.svg='$OTHER
  '*.svgz='$OTHER
  '*.mng='$OTHER
  '*.pcx='$OTHER
  '*.mov='$OTHER
  '*.mpg='$OTHER
  '*.mpeg='$OTHER
  '*.m2v='$OTHER
  '*.mkv='$OTHER
  '*.webm='$OTHER
  '*.ogm='$OTHER
  '*.mp4='$OTHER
  '*.m4v='$OTHER
  '*.mp4v='$OTHER
  '*.vob='$OTHER
  '*.qt='$OTHER
  '*.nuv='$OTHER
  '*.wmv='$OTHER
  '*.asf='$OTHER
  '*.rm='$OTHER
  '*.rmvb='$OTHER
  '*.flc='$OTHER
  '*.avi='$OTHER
  '*.fli='$OTHER
  '*.flv='$OTHER
  '*.gl='$OTHER
  '*.dl='$OTHER
  '*.xcf='$OTHER
  '*.xwd='$OTHER
  '*.yuv='$OTHER
  '*.cgm='$OTHER
  '*.emf='$OTHER
  '*.ogv='$OTHER
  '*.ogx='$OTHER

  # Audio media
  '*.aac='$OTHER
  '*.au='$OTHER
  '*.flac='$OTHER
  '*.m4a='$OTHER
  '*.mid='$OTHER
  '*.midi='$OTHER
  '*.mka='$OTHER
  '*.mp3='$OTHER
  '*.mpc='$OTHER
  '*.ogg='$OTHER
  '*.ra='$OTHER
  '*.wav='$OTHER
  '*.oga='$OTHER
  '*.opus='$OTHER
  '*.spx='$OTHER
  '*.xspf='$OTHER

  # Config
  '.*rc='$CONFIG
  '*conf='$CONFIG
  '*.git='$CONFIG
  '*.toml='$CONFIG
  '*.lock='$CONFIG
  '*.json='$CONFIG
  '*.sbt='$CONFIG
  '.gitignore='$CONFIG
  '.gitkeep='$CONFIG
  '.gitattrbiutes='$CONFIG
  '*.yaml='$CONFIG
  '*.yml='$CONFIG
  'Makefile='$CONFIG
  'Vagrantfile='$CONFIG

  # Code
  '*.ts='$CODE
  '*.js='$CODE
  '*.scala='$CODE
  '*.sc='$CODE
  '*.rs='$CODE
  '*.java='$CODE
  '*.py='$CODE
  '*.idr='$CODE
  '*.hs='$CODE
  '*.lhs='$CODE
  '*.html='$CODE
  '*.css='$CODE
  '*.sh='$CODE
  '*.zsh='$CODE
  '*.bash='$CODE
  '*.sql='$CODE
  '*.pl='$CODE

  # Dev Things
  '*.class='$OTHER
  '*.o='$OTHER
  '*.bin='$OTHER
  'DS_STORE='$OTHER
  '*.dylib='$OTHER
  '*.h='$OTHER
  '*.log='$OTHER
  '*.pom='$OTHER
  'LICENCE='$OTHER
  'LICENSE='$OTHER
  '*.md='$OTHER

  # Data
  '*.avro='$DATA
  '*.parquet='$DATA
  '*.avsc='$DATA
  '*.csv='$DATA
  '*.xml='$DATA
  '*.txt='$DATA
)

RAW_EXA_COLORS=(
  'hd='$FG$WHITE # The header row of a table.
  'xx='$FG$DGREY # "punctuation", including many background UI elements.

  'ur='$FG$DPURPLE # The user-read permission bit.
  'gr='$FG$DPURPLE # The group-read permission bit.
  'tr='$FG$DPURPLE # The world-read permission bit.

  'uw='$FG$PURPLE # The user-write permission bit.
  'gw='$FG$PURPLE # The group-write permission bit.
  'tw='$FG$PURPLE # The world-write permission bit.

  'ux='$FG$ORED # The user-execute permission bit for regular files.
  'ue='$FG$ORED # The user-execute for other file kinds.
  'gx='$FG$ORED # The group-execute permission bit.
  'tx='$FG$ORED # The world-execute permission bit.

  'sn='$FG$BLUE # The numbers of a file='s size.
  'sb='$FG$LBLUE # The units of a file='s size.

  'uu='$FG$DBLUE # A user that='s you.
  'un='$FG$LBLUE # A user that='s someone else.
  'gu='$FG$GREY # A group that you belong to.
  'gn='$FG$RED$BOLD # A group you aren't a member of.

  'da='$FG$LGREY # A file='s date.

  'ga='$FG$GITADD # A new flag in Git.
  'gm='$FG$GITCHANGE # A modified flag in Git.
  'gd='$RG$GITDELETE # A deleted flag in Git.
  'gv='$FG$GITADD # A renamed flag in Git.
  'gt='$FG$GITCHANGE # A modified metadata flag in Git.

  'lp='$FG$LGREY # The path of a symlink.
  'cc='$FG$PURPLE # An escaped character in a filename.
  'bO='$FG$RED # The overlay style for broken symlink paths.

  'xa='$FG$GREY # The extended attribute indicator.

  'df='$TODO # A device='s major ID.
  'ds='$TODO # A device='s minor ID.
  'lc='$TODO # A number of hard links.
  'lm='$TODO # A number of hard links for a regular file with at least two.
  'su='$TODO # Setuid, setgid, and sticky permission bits for files.
  'sf='$TODO # Setuid, setgid, and sticky for other file kinds.
  'in='$TODO # A file='s inode number.
  'bl='$TODO # A file='s number of blocks.
)
export LS_COLORS=${(j[:])RAW_LS_COLORS// /}
export EXA_COLORS=${(j[:])RAW_EXA_COLORS// /}
