#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# git pull origin master;

function setupBash() {
  # This copies (rsynchs) everything not specifically excluded to $HOME
  rsync -avh --no-perms --progress bash_dot_files/ $HOME
  rsync -avh --no-perms --progress bin/ $HOME/bin
  if [[ -d ~/Library/Fonts ]]; then
    rsync --exclude ".DS_Store" -av --no-perms --progress fonts/ ~/Library/Fonts/
  fi
  # cp init/sadserver_tweets.dat /usr/local/share/games/fortunes
  source ~/.bash_profile;
}

function setupFish() {
  rm -rf ~/.config/fish
  if [[ -f /usr/local/bin/fish ]]; then
    # OSX + homebrew
    echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/fish
  else
    chsh -s /usr/bin/fish
  fi
  rsync -avh --no-perms --progress fish/ ~/.config/fish
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
  fisher fzf
}

function setupVim() {
  rm -rf ~/.vim
  cp the_dot_files/.vimrc ~/
  rsync -avh --no-perms --progress .vim/colors ~/.vim
  rsync -avh --no-perms --progress .vim/syntax ~/.vim
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
  rsync -avh --no-perms --progress the_dot_files/ $HOME
  while getopts ":olvtbf" opt; do
    case $opt in
      b)
        echo " *** Bootstrap Bash ***"
        setupBash
        ;;
      f)
        echo " *** Bootstrap Fish shell *** "
        setupFish
        ;;
      o)
        echo " *** Bootstrap OSX ***"
        bootstrap_osx.sh
        brew.sh
        ;;
      l)
        echo " *** Bootstrap Linux ***"
        bootstrap_linux.sh
        ;;
      v)
        echo " *** Bootstrap vim ***"
        setupVim
        ;;
      t)
        echo " *** Bootstrap tmux plugins ***"
        setupTmux
        ;;
    esac
  done
fi;

unset setupBash;
unset setupFish;
unset setupVim;
unset setupTmux;
