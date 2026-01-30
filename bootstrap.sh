#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

function setupHomebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  /usr/local/dotfiles/brew.sh
}

function setupRVM() {
  gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s -- --autolibs=read-fail
}

function setupDotfileSymlinks() {
  # Create symlinks for primary dotfiles (called by specific setup functions)
  # Backs up existing files before symlinking
  echo "Creating dotfile symlinks..."

  # Create backup directory if needed
  if [[ -f ~/.zshrc ]] || [[ -f ~/.vimrc ]] || [[ -f ~/.tmux.conf ]]; then
    mkdir -p ~/.dotfiles_backup
    [[ -f ~/.zshrc ]] && cp ~/.zshrc ~/.dotfiles_backup/
    [[ -f ~/.vimrc ]] && cp ~/.vimrc ~/.dotfiles_backup/
    [[ -f ~/.tmux.conf ]] && cp ~/.tmux.conf ~/.dotfiles_backup/
    echo "Backed up existing dotfiles to ~/.dotfiles_backup/"
  fi

  # Create symlinks
  ln -sf /usr/local/dotfiles/zsh/.zshrc ~/.zshrc
  ln -sf /usr/local/dotfiles/the_dot_files/.vimrc ~/.vimrc
  ln -sf /usr/local/dotfiles/the_dot_files/.tmux.conf ~/.tmux.conf
  echo "✓ Symlinks created"
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
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-git-prompt/zsh-git-prompt.git ~/.oh-my-zsh/custom/plugins/zsh-git-prompt
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
  # Note: zsh-syntax-highlighting removed (redundant with fast-syntax-highlighting)
  # Note: zsh-autocomplete removed (too aggressive, using zsh-autosuggestions instead)
  # Note: zsh-abbr installed via Homebrew, not as plugin

  # Symlink .zshrc instead of copying
  if [[ -f ~/.zshrc ]]; then
    mv ~/.zshrc ~/.zshrc.backup
  fi
  ln -sf /usr/local/dotfiles/zsh/.zshrc ~/.zshrc
  source ~/.zshrc
}

function setupVim() {
  rm -rf ~/.vim
  # Symlink .vimrc instead of copying
  if [[ -f ~/.vimrc ]]; then
    mv ~/.vimrc ~/.vimrc.backup
  fi
  ln -sf /usr/local/dotfiles/the_dot_files/.vimrc ~/.vimrc
  rsync -avh --ignore-times --no-perms --progress .vim/colors ~/.vim
  rsync -avh --ignore-times --no-perms --progress .vim/syntax ~/.vim
  git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
  vim +PluginInstall +qall
}

function setupTmux() {
  rm -rf ~/.tmux/plugins
  # Symlink .tmux.conf instead of copying
  if [[ -f ~/.tmux.conf ]]; then
    mv ~/.tmux.conf ~/.tmux.conf.backup
  fi
  ln -sf /usr/local/dotfiles/the_dot_files/.tmux.conf ~/.tmux.conf
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  tmux source ~/.tmux.conf
}

read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
  git submodule update --init --recursive
  # Note: Main dotfiles (.zshrc, .vimrc, .tmux.conf) are now symlinked via setup functions
  # Only rsync non-primary dotfiles
  rsync -avh --ignore-times --no-perms --progress --exclude='.vimrc' --exclude='.tmux.conf' the_dot_files/ $HOME
  sudo pip3 install --upgrade pip
  sudo pip3 install --upgrade setuptools
  PYTHON_PACKAGES=(
    autopep8
    flake8
    httplib2
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
  while getopts ":bfholtsvz" opt; do
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
      s)
        echo " *** Create dotfile symlinks ***"
        setupDotfileSymlinks
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
unset setupDotfileSymlinks;
unset setupFish;
unset setupHomebrew;
unset setupRVM;
unset setupSettings;
unset setupTmux;
unset setupVim;
unset setupZsh;
