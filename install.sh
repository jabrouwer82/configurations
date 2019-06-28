#! /bin/bash

echo -e '\033[1;36mThis is only mostly tested, use at your own risk!\033[0m'

echo -e '\033[1;36mInstalling systemd units...\033[0m'
sudo ln -sf "$(pwd)"/systemd/trash-empty.service /usr/lib/systemd/system/trash-empty.service
sudo ln -sf "$(pwd)"/systemd/trash-empty.timer /usr/lib/systemd/system/trash-empty.timer
sudo ln -sf "$(pwd)"/trash-empty.sh ~/trash-empty.sh
sudo ln -sf "$(pwd)"/systemd/vimplug-update.service /usr/lib/systemd/system/vimplug-update.service
sudo ln -sf "$(pwd)"/systemd/vimplug-update.timer /usr/lib/systemd/system/vimplug-update.timer
sudo ln -sf "$(pwd)"/.vimplug-update.sh ~/vimplug-update.sh
systemctl daemon-reload
systemctl reenable --now trash-empty.timer
systemctl reenable --now vimplug-update.timer


echo -e '\033[1;36mInstalling home dir configs, eg bash, vim, git...\033[0m'
ln -sf "$(pwd)"/.vimrc ~/.vimrc
ln -sf "$(pwd)"/.bashrc ~/.bashrc
ln -sf "$(pwd)"/.tmux.conf ~/.tmux.conf
ln -sf "$(pwd)"/.tmux.vim.conf ~/.tmux.vim.conf
ln -sf "$(pwd)"/.gitconfig ~/.gitconfig
ln -sf "$(pwd)"/recover.sh ~/recover.sh
ln -sf "$(pwd)"/.gitall.sh ~/.gitall.sh
find "$(pwd)/linters" -type f -exec ln -s {} ~/ \;

echo -e '\033[1;36mInstalling more vim stuff...\033[0m'
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/bundle
ln -sf "$(pwd)"/.vim/Dec2hex.vim ~/.vim/Dec2hex.vim
ln -sf "$(pwd)"/.vim/colors/jacob.vim ~/.vim/colors/jacob.vim

echo -e '\033[1;36mInstalling xorg configs...\033[0m'
sudo ln -sf "$(pwd)"/xorg/50-marblemouse.conf /etc/X11/xorg.conf.d/50-marblemouse.conf
sudo ln -sf "$(pwd)"/xorg/51-m570.conf /etc/X11/xorg.conf.d/51-m570.conf
sudo ln -sf "$(pwd)"/xorg/51-mxergo.conf /etc/X11/xorg.conf.d/51-mxergo.conf
sudo ln -sf "$(pwd)"/xorg/51-trackpoint.conf /etc/X11/xorg.conf.d/51-trackpoint.conf

