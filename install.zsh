#! /bin/zsh

# TODO: Switch all this crap to gnu stow and/or nix.

echo -e '\n\033[1;36mThis is only kind of tested, use at your own risk!\033[0m\n'

if [[ ! -f ~/.github_token.sh ]]; then
  echo -e '\033[31mExport GITHUB_TOKEN in ~/.github_token.sh before attmpting to install.\033[0m'
  exit 1
fi

echo -e '\033[32mCreating dirs...\033[0m'
mkdir -p ~/work
mkdir -p ~/thirdparty
mkdir -p ~/personal

echo -e '\033[32mInstalling vim configs...\033[0m'
ln -sf "$(pwd)"/.vimrc ~/.vimrc
mkdir -p ~/.config/nvim/lua
ln -sf "$(pwd)"/.nvim/init.vim ~/.config/nvim/init.vim
ln -sf "$(pwd)"/.nvim/ginit.vim ~/.config/nvim/ginit.vim
ln -sf "$(pwd)"/.nvim/lua/plugins.lua ~/.config/nvim/lua/plugins.lua
mkdir -p ~/.vim/autoload/airline/themes
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/spell
mkdir -p ~/.vim/tmp/back
mkdir -p ~/.vim/tmp/undo
mkdir -p ~/.vim/tmp/dir
ln -sf "$(pwd)"/.vim/Dec2hex.vim ~/.vim/Dec2hex.vim
ln -sf "$(pwd)"/.vim/autoload/airline/themes/jacob.vim ~/.vim/autoload/airline/themes/jacob.vim
ln -sf "$(pwd)"/.vim/coc-settings.json ~/.vim/coc-settings.json
ln -sf "$(pwd)"/.vim/colors/jacob.vim ~/.vim/colors/jacob.vim
ln -sf "$(pwd)"/.vim/spell/en.utf-8.add ~/.vim/spell/en.utf-8.add
ln -sf "$(pwd)"/backup.sh ~/.vim/tmp/backup.sh
ln -sf "$(pwd)"/.vimtmpgitignore ~/.vim/tmp/.gitignore
touch ~/.viminfo
chown $USER ~/.viminfo
git -C ~/.vim/tmp/ init -q

echo -e '\033[32mInstalling zsh configs...\033[0m'
mkdir -p ~/.config/fsh
ln -sf "$(pwd)"/.zshenv ~/.zshenv
ln -sf "$(pwd)"/.zshrc ~/.zshrc
ln -sf "$(pwd)"/.zsh_plugins.txt ~/.zsh_plugins.txt
ln -sf "$(pwd)"/.p10k.zsh ~/.p10k.zsh
ln -sf "$(pwd)"/.exa_colors.zsh ~/.exa_colors.zsh
ln -sf "$(pwd)"/fsh/jacob.ini ~/.config/fsh/jacob.ini

echo -e '\033[32mInstalling git configs...\033[0m'
ln -sf "$(pwd)"/.gitconfig ~/.gitconfig
ln -sf "$(pwd)"/.personal.gitconfig ~/.personal.gitconfig
ln -sf "$(pwd)"/.gitall.sh ~/.gitall.sh

echo -e '\033[32mInstalling linter configs...\033[0m'
mkdir -p ~/.config
find "$(pwd)/linters" -type f -exec ln -sf {} ~/ \;
ln -sf "$(pwd)"/linters/flake8 ~/.config/flake8

echo -e '\033[32mInstalling ripgrep configs...\033[0m'
ln -sf "$(pwd)"/.ripgreprc ~/.ripgreprc

echo -e '\033[32mInstalling ammonite configs...\033[0m'
mkdir -p ~/.ammonite
ln -sf "$(pwd)"/.ammonite/predefScript.sc ~/.ammonite/predef.sc
ln -sf "$(pwd)"/.ammonite/predef.sc ~/.ammonite/predef.sc
ln -sf "$(pwd)"/.ammonite/spark-predef.sc ~/.ammonite/spark-predef.sc
ln -sf "$(pwd)"/.ammonite/configure-compiler.sc ~/.ammonite/configure-compiler.sc

echo -e '\033[32mInstalling bat configs...\033[0m'
mkdir -p ~/.config/bat/themes
ln -sf "$(pwd)"/bat/bat.conf ~/.config/bat/config
ln -sf "$(pwd)"/bat/jacob.tmTheme ~/.config/bat/themes/jacob.tmTheme
bat cache --build > /dev/null

echo -e '\033[32mInstalling sbt configs...\033[0m'
mkdir -p ~/.sbt/1.0/plugins/
ln -sf "$(pwd)"/sbt/global.sbt ~/.sbt/1.0/plugins/global.sbt
ln -sf "$(pwd)"/.scalafix.conf ~/.scalafix.conf


case "$OSTYPE" in
  darwin*)
    echo -e '\033[32mInstalling Library key bindings...\033[0m'
    ln -sf "$(pwd)"/macos/Library/DefaultKeyBindings.dict ~/Library/DefaultKeyBindings.dict
    echo -e '\033[32mChecking that brew is installed...\033[0m'
    type brew &> /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo -e '\033[32mInstalling everything in the Brewfile...\033[0m'
    brew bundle
  ;;
  linux*)
    echo -e '\033[32mInstalling systemd units...\033[0m'
    sudo ln -sf "$(pwd)"/systemd/trash-empty.service /usr/lib/systemd/system/trash-empty.service
    sudo ln -sf "$(pwd)"/systemd/trash-empty.timer /usr/lib/systemd/system/trash-empty.timer
    sudo ln -sf "$(pwd)"/trash-empty.sh ~/trash-empty.sh
    sudo ln -sf "$(pwd)"/systemd/vimplug-update.service /usr/lib/systemd/system/vimplug-update.service
    sudo ln -sf "$(pwd)"/systemd/vimplug-update.timer /usr/lib/systemd/system/vimplug-update.timer
    sudo ln -sf "$(pwd)"/.vimplug-update.sh ~/vimplug-update.sh
    systemctl daemon-reload
    systemctl reenable --now trash-empty.timer
    systemctl reenable --now vimplug-update.timer

    echo -e '\033[32mInstalling xorg configs...\033[0m'
    sudo ln -sf "$(pwd)"/xorg/50-marblemouse.conf /etc/X11/xorg.conf.d/50-marblemouse.conf
    sudo ln -sf "$(pwd)"/xorg/51-m570.conf /etc/X11/xorg.conf.d/51-m570.conf
    sudo ln -sf "$(pwd)"/xorg/51-mxergo.conf /etc/X11/xorg.conf.d/51-mxergo.conf
    sudo ln -sf "$(pwd)"/xorg/51-trackpoint.conf /etc/X11/xorg.conf.d/51-trackpoint.conf

    echo -e '\033[34mPackage installation isn'"'"'t automated on linux yet, exiting now.\033[0m'
    exit 0
  ;;
esac

echo -e '\033[32mInstalling scala stuff...\033[0m'
cs setup
cs install scalafmt,scalafix,metals
echo -e '\033[32mInstalling jvms...\033[0m'
cs java-home --jvm 8
cs java-home --jvm 11
cs java-home --jvm 17
cs java-home --jvm 21
sudo ln -sf "$(cs java-home --jvm 17)" /Library/Java/JavaVirtualMachines/jdk

echo -e '\033[32mConfiguring jenv...\033[0m'
mkdir -p ~/.jenv/versions
jenv add $(cs java-home --jvm 8)
jenv add $(cs java-home --jvm 11)
jenv add $(cs java-home --jvm 17)
jenv add $(cs java-home --jvm 21)

echo -e '\033[32mInstalling neovim Plug plugins...\033[0m'
nvim --headless +PlugInstall +qall
echo -e '\033[32mInstalling neovim Packer plugins...\033[0m'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
