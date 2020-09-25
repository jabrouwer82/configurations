#! /bin/zsh

# TODO: Switch all this crap to gnu stow and add separation for unix and macos things

echo -e '\033[1;36mThis is only kind of tested, use at your own risk!\033[0m'

#echo -e '\033[1;36mInstalling systemd units...\033[0m'
#sudo ln -sf "$(pwd)"/systemd/trash-empty.service /usr/lib/systemd/system/trash-empty.service
#sudo ln -sf "$(pwd)"/systemd/trash-empty.timer /usr/lib/systemd/system/trash-empty.timer
#sudo ln -sf "$(pwd)"/trash-empty.sh ~/trash-empty.sh
#sudo ln -sf "$(pwd)"/systemd/vimplug-update.service /usr/lib/systemd/system/vimplug-update.service
#sudo ln -sf "$(pwd)"/systemd/vimplug-update.timer /usr/lib/systemd/system/vimplug-update.timer
#sudo ln -sf "$(pwd)"/.vimplug-update.sh ~/vimplug-update.sh
#systemctl daemon-reload
#systemctl reenable --now trash-empty.timer
#systemctl reenable --now vimplug-update.timer

echo -e '\033[1;36mInstalling vim configs...\033[0m'
ln -sf "$(pwd)"/.vimrc ~/.vimrc
mkdir -p ~/.vim/autoload/airline/themes
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/spell
mkdir -p ~/.vim/tmp/back
mkdir -p ~/.vim/tmp/undo
mkdir -p ~/.vim/tmp/dir
ln -sf "$(pwd)"/.vim/Dec2hex.vim ~/.vim/Dec2hex.vim
ln -sf "$(pwd)"/.vim/autoload/airline/themes/jacob.vim ~/.vim/autoload/airline/themes/jacob.vim
ln -sf "$(pwd)"/.vim/coc-settings.json ~/.vim/coco-settings.json
ln -sf "$(pwd)"/.vim/colors/jacob.vim ~/.vim/colors/jacob.vim
ln -sf "$(pwd)"/.vim/spell/en.utf-8.add ~/.vim/spell/en.utf-8.add
ln -sf "$(pwd)"/backup.sh ~/.vim/tmp/backup.sh
ln -sf "$(pwd)"/.vimtmpgitignore ~/.vim/tmp/.gitignore
git -C ~/.vim/tmp/ init -q

echo -e '\033[1;36mInstalling zsh configs...\033[0m'
mkdir -p ~/.config/fsh
ln -sf "$(pwd)"/.zshenv ~/.zshenv
ln -sf "$(pwd)"/.zshrc ~/.zshrc
ln -sf "$(pwd)"/.p10k.zsh ~/.p10k.zsh
ln -sf "$(pwd)"/.exa_colors.zsh ~/.exa_colors.zsh
ln -sf "$(pwd)"/fsh/jacob.ini ~/.config/fsh/jacob.ini

echo -e '\033[1;36mInstalling git configs...\033[0m'
ln -sf "$(pwd)"/.gitconfig ~/.gitconfig
ln -sf "$(pwd)"/.gitall.sh ~/.gitall.sh

echo -e '\033[1;36mInstalling linter configs...\033[0m'
mkdir -p ~/.config
find "$(pwd)/linters" -type f -exec ln -sf {} ~/ \;
ln -sf "$(pwd)"/linters/flake8 ~/.config/flake8

echo -e '\033[1;36mInstalling ripgrep configs...\033[0m'
ln -sf "$(pwd)"/.ripgreprc ~/.ripgreprc

echo -e '\033[1;36mInstalling ammonite configs...\033[0m'
mkdir -p ~/.ammonite
ln -sf "$(pwd)"/.ammonite/predefScript.sc ~/.ammonite/predef.sc
ln -sf "$(pwd)"/.ammonite/predef.sc ~/.ammonite/predef.sc

echo -e '\033[1;36mInstalling bat configs...\033[0m'
mkdir -p ~/.config/bat/themes
ln -sf "$(pwd)"/bat/bat.conf ~/.config/bat/config
ln -sf "$(pwd)"/bat/jacob.tmTheme ~/.config/bat/themes/jacob.tmTheme
bat cache --build > /dev/null

echo -e '\033[1;36mInstalling sbt configs...\033[0m'
mkdir -p ~/.sbt/1.0/plugins/
ln -sf "$(pwd)"/sbt/global.sbt ~/.sbt/1.0/plugins/global.sbt

# echo -e '\033[1;36mInstalling xorg configs...\033[0m'
# sudo ln -sf "$(pwd)"/xorg/50-marblemouse.conf /etc/X11/xorg.conf.d/50-marblemouse.conf
# sudo ln -sf "$(pwd)"/xorg/51-m570.conf /etc/X11/xorg.conf.d/51-m570.conf
# sudo ln -sf "$(pwd)"/xorg/51-mxergo.conf /etc/X11/xorg.conf.d/51-mxergo.conf
# sudo ln -sf "$(pwd)"/xorg/51-trackpoint.conf /etc/X11/xorg.conf.d/51-trackpoint.conf

