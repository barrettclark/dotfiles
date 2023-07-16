#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

function setupHomebrew() {
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  /usr/local/dotfiles/brew.sh
}

function setupRVM() {
  gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s -- --autolibs=read-fail
}

function setupSettings() {
  # Fonts Mac
  if [[ -d ~/Library/Fonts ]]; then
    rsync --exclude ".DS_Store" -av --ignore-times --no-perms --progress fonts/ ~/Library/Fonts/
  fi
  # Fonts Linux
  if [[ -d /usr/local/share/fonts ]]; then
    sudo rsync --exclude ".DS_Store" -av --ignore-times --no-perms --progress fonts/ /usr/local/share/fonts/
    fc-cache -f -v
  fi
  # if [[ -d /usr/local/share/games/fortunes ]]; then
  #   rsync -av --ignore-times --no-perms --progress init/sadserver_tweets* /usr/local/share/games/fortunes
  # fi
}

function setupBash() {
  # This copies (rsynchs) everything not specifically excluded to $HOME
  rsync -avh --ignore-times --no-perms --progress bash_dot_files/ $HOME
  rsync -avh --ignore-times --no-perms --progress bin/ $HOME/bin
  setupSettings
  source ~/.bash_profile
}

function setupFish() {
  setupSettings
  rm -rf ~/.config/fish
  if [[ -f /usr/local/bin/fish ]]; then
    echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/fish
  else
    chsh -s /usr/bin/fish
  fi
  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
  fisher install PatrickF1/fzf.fish nyarly/fish-rake-complete brgmnn/fish-docker-compose rstacruz/fish-asdf
  rsync -avh --ignore-times --no-perms --progress /usr/local/dotfiles/fish/ ~/.config/fish
}

function setupZsh() {
  if [[ -f /usr/local/bin/zsh ]]; then
    echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/zsh
  else
    chsh -s /usr/bin/zsh
  fi
  git clone https://github.com/zsh-git-prompt/zsh-git-prompt.git $ZSH_CUSTOM/plugins/zsh-git-prompt
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-fast-syntax-highlighting
  git clone https://github.com/marlonrichert/zsh-autocomplete.git --depth 1 $ZSH_CUSTOM/plugins/zsh-autocomplete
  git clone https://github.com/olets/zsh-abbr --single-branch --branch main --depth 1 $ZSH_CUSTOM/plugins/zsh-abbr
  cp /usr/local/dotfiles/zsh/.zshrc $HOME
  source ~/.zshrc
}

function setupVim() {
  rm -rf ~/.vim
  cp the_dot_files/.vimrc ~/
  rsync -avh --ignore-times --no-perms --progress .vim/colors ~/.vim
  rsync -avh --ignore-times --no-perms --progress .vim/syntax ~/.vim
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
  rsync -avh --ignore-times --no-perms --progress the_dot_files/ $HOME
  sudo pip3 install --upgrade pip
  sudo pip3 install --upgrade setuptools
  PYTHON_PACKAGES=(
    autopep8
    flake8
    ipython
    pygments
    pylint
    sqlparse
    virtualenv
    virtualenvwrapper
    yapf
  )
  sudo pip3 install ${PYTHON_PACKAGES[@]}
  # npm install -g csslint fx markdownlint-cli moment prettier
  while getopts ":bfholtvz" opt; do
    case $opt in
      b)
        echo " *** Bootstrap Bash ***"
        setupBash
        ;;
      f)
        echo " *** Bootstrap Fish shell ***"
        setupFish
        ;;
      h)
        echo " *** Bootstrap Homebrew ***"
        setupHomebrew
        ;;
      o)
        echo " *** Bootstrap macOS ***"
        ./bootstrap_macos.sh $2
        setupHomebrew
        setupRVM
        ;;
      l)
        echo " *** Bootstrap Linux ***"
        bootstrap_linux.sh
        ;;
      t)
        echo " *** Bootstrap tmux plugins ***"
        setupTmux
        ;;
      v)
        echo " *** Bootstrap vim ***"
        setupVim
        ;;
      z)
        echo " *** Bootstrap zsh ***"
        setupZsh
        ;;
    esac
  done
fi;

unset setupBash;
unset setupFish;
unset setupHomebrew;
unset setupRVM;
unset setupSettings;
unset setupTmux;
unset setupVim;
