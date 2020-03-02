FG='38;2;'
BG='48;2;'
BOLD=';1'
UNDER=';4'
OFF='0'

TODO=$FG$jwhiteexa';'$BG$jlredexa
CHECK=$FG$jlredexa';'$BG$jwhiteexa
CODE=$FG$jlblueexa
CONFIG=$FG$jlpurpleexa
OTHER=$FG$jdblueexa
DATA=$FG$jgreenexa

RAW_LS_COLORS=(
  'no='$TODO # Default.
  'rs='$OFF # Reset.

  'di='$FG$jlgreenexa # Directories.
  'ex='$FG$jlorangeexa # Executable Files.
  'fi='$FG$jlgreyexa # Normal file.
  'ln='$FG$jwhiteexa # Symlinks.
  'mh='$FG$jwhiteexa # Regular files with more than one line.
  'mi='$UNDER$FG$jlredexa$UNDER # Non-existent file pointed to by a symbolic link.
  'or='$FG$jlredexa # Symlinks with no target.
  'pi='$FG$jlorangeexa # Named Pipes.

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
  '.*env='$CONFIG
  '*conf='$CONFIG
  '*config='$CONFIG
  '*attributes='$CONFIG
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
  '*.cfg='$CONFIG
  '*.ini='$CONFIG
  '*.properties='$CONFIG
  '.python-version='$CONFIG

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
  '*.tsv='$DATA
  '*.xml='$DATA
  '*.txt='$DATA
)

RAW_EXA_COLORS=(
  'hd='$FG$jwhiteexa # The header row of a table.
  'xx='$FG$jdgreyexa # "punctuation", including many background UI elements.

  'ur='$FG$jpurpleexa # The user-read permission bit.
  'gr='$FG$jpurpleexa # The group-read permission bit.
  'tr='$FG$jpurpleexa # The world-read permission bit.

  'uw='$FG$jlpurpleexa # The user-write permission bit.
  'gw='$FG$jlpurpleexa # The group-write permission bit.
  'tw='$FG$jlpurpleexa # The world-write permission bit.

  'ux='$FG$jlredexa # The user-execute permission bit for regular files.
  'ue='$FG$jlredexa # The user-execute for other file kinds.
  'gx='$FG$jlredexa # The group-execute permission bit.
  'tx='$FG$jlredexa # The world-execute permission bit.

  'sn='$FG$jblueexa # The numbers of a file='s size.
  'sb='$FG$jlblueexa # The units of a file='s size.

  'uu='$FG$jdblueexa # A user that='s you.
  'un='$FG$jlblueexa # A user that='s someone else.
  'gu='$FG$jgreyexa # A group that you belong to.
  'gn='$FG$jlredexa$BOLD # A group you aren't a member of.

  'da='$FG$jlgreyexa # A file='s date.

  'ga='$FG$jgreenexa # A new flag in Git.
  'gm='$FG$jlblueexa # A modified flag in Git.
  'gd='$RG$jlredexa # A deleted flag in Git.
  'gv='$FG$jgreenexa # A renamed flag in Git.
  'gt='$FG$jlblueexa # A modified metadata flag in Git.

  'lp='$FG$jlgreyexa # The path of a symlink.
  'cc='$FG$jpurpleexa # An escaped character in a filename.
  'bO='$FG$jlredexa # The overlay style for broken symlink paths.

  'xa='$FG$jgreyexa # The extended attribute indicator.

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
