#! /bin/zsh

# TODO: Switch all this crap to gnu stow or nix.

echo -e '\n\033[1;36mThis is only kind of tested, use at your own risk!\033[0m\n'

if [[ ! -f ~/.github_token.sh ]]; then
  echo -e '\033[31mExport GITHUB_TOKEN in ~/.github_token.sh before attmpting to install.\033[0m'
  cp -n github_token.sh ~/.github_token.sh
  exit 1
fi

echo -e '\033[32mCreating dirs...\033[0m'
mkdir -p ~/work
mkdir -p ~/thirdparty
mkdir -p ~/personal
mkdir -p ~/.config
touch ~/.jacob

echo -e '\033[32mInstalling vim configs...\033[0m'
ln -sfn "$(pwd)"/config/nvim ~/.config/nvim
mkdir -p ~/.vim/autoload/airline/themes
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/spell
mkdir -p ~/.vim/tmp/back
mkdir -p ~/.vim/tmp/undo
mkdir -p ~/.vim/tmp/dir
ln -sfn "$(pwd)"/.vim/Dec2hex.vim ~/.vim/Dec2hex.vim
ln -sfn "$(pwd)"/.vim/autoload/airline/themes/jacob.vim ~/.vim/autoload/airline/themes/jacob.vim
ln -sfn "$(pwd)"/.vim/coc-settings.json ~/.vim/coc-settings.json
ln -sfn "$(pwd)"/.vim/colors/jacob.vim ~/.vim/colors/jacob.vim
ln -sfn "$(pwd)"/.vim/spell/en.utf-8.add ~/.vim/spell/en.utf-8.add
ln -sfn "$(pwd)"/backup.sh ~/.vim/tmp/backup.sh
ln -sfn "$(pwd)"/.vimtmpgitignore ~/.vim/tmp/.gitignore
touch ~/.viminfo
chown $USER ~/.viminfo
git -C ~/.vim/tmp/ init -q

echo -e '\033[32mInstalling zsh configs...\033[0m'
ln -sfn "$(pwd)"/config/fsh ~/.config/fsh
ln -sfn "$(pwd)"/.zshenv ~/.zshenv
ln -sfn "$(pwd)"/.zlogin ~/.zlogin
ln -sfn "$(pwd)"/.zshrc ~/.zshrc
ln -sfn "$(pwd)"/.zsh_plugins.txt ~/.zsh_plugins.txt
ln -sfn "$(pwd)"/.p10k.zsh ~/.p10k.zsh
ln -sfn "$(pwd)"/.exa_colors.zsh ~/.exa_colors.zsh
touch ~/.work.zsh

echo -e '\033[32mInstalling git configs...\033[0m'
if [[ ! -f ~/.github_token.sh ]]; then
  echo -e '\033[31mSet work email in ~/.work.gitconfig.\033[0m'
  cp -n .personal.gitconfig ~/.work.gitconfig
fi
ln -sfn "$(pwd)"/.gitconfig ~/.gitconfig
ln -sfn "$(pwd)"/.personal.gitconfig ~/.personal.gitconfig
ln -sfn "$(pwd)"/.gitall.sh ~/.gitall.sh

# echo -e '\033[32mInstalling linter configs...\033[0m'
# find "$(pwd)/linters" -type f -exec ln -sfn {} ~/ \;

echo -e '\033[32mInstalling ripgrep configs...\033[0m'
ln -sfn "$(pwd)"/.ripgreprc ~/.ripgreprc

echo -e '\033[32mInstalling ammonite configs...\033[0m'
mkdir -p ~/.ammonite
ln -sfn "$(pwd)"/.ammonite/predefScript.sc ~/.ammonite/predef.sc
ln -sfn "$(pwd)"/.ammonite/predef.sc ~/.ammonite/predef.sc
ln -sfn "$(pwd)"/.ammonite/spark-predef.sc ~/.ammonite/spark-predef.sc
ln -sfn "$(pwd)"/.ammonite/configure-compiler.sc ~/.ammonite/configure-compiler.sc

echo -e '\033[32mInstalling bat configs...\033[0m'
ln -sfn "$(pwd)"/config/bat ~/.config/bat
bat cache --build > /dev/null

echo -e '\033[32mInstalling sbt configs...\033[0m'
mkdir -p ~/.sbt/1.0/plugins/
ln -sfn "$(pwd)"/.scalafix.conf ~/.scalafix.conf


case "$OSTYPE" in
  darwin*)
    echo -e '\033[32mInstalling Library key bindings...\033[0m'
    ln -sfn "$(pwd)"/macos/Library/DefaultKeyBindings.dict ~/Library/DefaultKeyBindings.dict
    echo -e '\033[32mChecking that brew is installed...\033[0m'
    type brew &> /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo -e '\033[32mInstalling everything in the Brewfile...\033[0m'
    brew bundle
  ;;
  linux*)
    echo -e '\033[32mInstalling systemd units...\033[0m'
    sudo ln -sfn "$(pwd)"/systemd/trash-empty.service /usr/lib/systemd/system/trash-empty.service
    sudo ln -sfn "$(pwd)"/systemd/trash-empty.timer /usr/lib/systemd/system/trash-empty.timer
    sudo ln -sfn "$(pwd)"/trash-empty.sh ~/trash-empty.sh
    sudo ln -sfn "$(pwd)"/systemd/vimplug-update.service /usr/lib/systemd/system/vimplug-update.service
    sudo ln -sfn "$(pwd)"/systemd/vimplug-update.timer /usr/lib/systemd/system/vimplug-update.timer
    sudo ln -sfn "$(pwd)"/.vimplug-update.sh ~/vimplug-update.sh
    systemctl daemon-reload
    systemctl reenable --now trash-empty.timer
    systemctl reenable --now vimplug-update.timer

    echo -e '\033[32mInstalling xorg configs...\033[0m'
    sudo ln -sfn "$(pwd)"/xorg/50-marblemouse.conf /etc/X11/xorg.conf.d/50-marblemouse.conf
    sudo ln -sfn "$(pwd)"/xorg/51-m570.conf /etc/X11/xorg.conf.d/51-m570.conf
    sudo ln -sfn "$(pwd)"/xorg/51-mxergo.conf /etc/X11/xorg.conf.d/51-mxergo.conf
    sudo ln -sfn "$(pwd)"/xorg/51-trackpoint.conf /etc/X11/xorg.conf.d/51-trackpoint.conf

    echo -e '\033[34mPackage installation isn'"'"'t automated on linux yet.\033[0m'
    # exit 0
  ;;
esac

echo -e '\033[32mInstalling scala stuff...\033[0m'
case "$OSTYPE" in
  darwin*)
  ;;
  linux*)
    coursier install cs
  ;;
esac
cs setup
cs install scalafmt scalafix metals
echo -e '\033[32mInstalling jvms...\033[0m'
cs java-home --jvm 8
cs java-home --jvm 11
cs java-home --jvm 17
cs java-home --jvm 21
case "$OSTYPE" in
  darwin*)
    sudo ln -sfn "$(cs java-home --jvm 17)" /Library/Java/JavaVirtualMachines/jdk
  ;;
  linux*)
    sudo ln -sfn "$(cs java-home --jvm 17)" /usr/lib/jvm/
  ;;
esac

echo -e '\033[32mConfiguring jenv...\033[0m'
mkdir -p ~/.jenv/versions
jenv add $(cs java-home --jvm 8)
jenv add $(cs java-home --jvm 11)
jenv add $(cs java-home --jvm 17)
jenv add $(cs java-home --jvm 21)

echo -e '\033[32mInstalling neovim Plug plugins...\033[0m'
nvim --headless "+Lazy! sync" +qall
