#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function copyDotFiles() {
  # This copies (rsynchs) everything not specifically excluded to $HOME
  rsync -avh --no-perms --progress the_dot_files/ $HOME
  rsync -avh --no-perms --progress bin/ $HOME/bin
  if [[ -d ~/Library/Fonts ]]; then
    rsync --exclude ".DS_Store" -av --no-perms --progress fonts/ ~/Library/Fonts/
  fi
  # cp init/sadserver_tweets.dat /usr/local/share/games/fortunes
  source ~/.bash_profile;
}

function setupVim() {
  rm -rf ~/.vim
  git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
}

function setupTmux() {
  rm -rf ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  tmux source ~/.tmux.conf
}

read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
  copyDotFiles;
  while getopts ":ol" opt; do
    case $opt in
      o)
        echo "Bootstrap OSX"
        bootstrap_osx.sh
        ;;
      l)
        echo "Bootstrap Linux"
        bootstrap_linux.sh
        ;;
    esac
  done
  setupVim;
  setupTmux;
fi;

unset copyDotFiles;
unset setupVim;
unset setupTmux;
