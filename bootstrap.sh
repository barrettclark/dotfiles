#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
  # This copies (rsynchs) everything not specifically excluded to $HOME
  # This does NOT run ./osx or ./brew.sh
  rm -rf ~/.vim

	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE-MIT.txt" --exclude "fonts/" \
    --exclude "init/" --exclude ".osx" --exclude "brew.sh" \
    --exclude "tmux_setup.sh" -avh --no-perms . ~;
  rsync --exclude ".DS_Store" -av --no-perms fonts/ ~/Library/Fonts/

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
