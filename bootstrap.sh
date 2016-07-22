#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
  # This copies (rsynchs) everything not specifically excluded to $HOME
  # This does NOT run ./osx or ./brew.sh
  rm -rf ~/.vim

  rsync -avh --no-perms --progress the_dot_files/ $HOME
  rsync -avh --no-perms --progress bin/ $HOME/bin
  rsync --exclude ".DS_Store" -av --no-perms --progress fonts/ ~/Library/Fonts/
  # cp init/sadserver_tweets.dat /usr/local/share/games/fortunes

  git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall

  source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
unset doIt;
