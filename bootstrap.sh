#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

function setupSudoAskpass() {
  mkdir -p ~/bin
  cp /usr/local/dotfiles/bin/sudo-askpass.sh ~/bin/sudo-askpass.sh
  chmod +x ~/bin/sudo-askpass.sh
  export SUDO_ASKPASS="$HOME/bin/sudo-askpass.sh"
  echo "✓ sudo-askpass.sh deployed to ~/bin"
}

function setupHomebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  /usr/local/dotfiles/brew.sh
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
  mkdir -p ~/.config
  if [[ -d ~/.config/nvim && ! -L ~/.config/nvim ]]; then
    mkdir -p ~/.dotfiles_backup
    mv ~/.config/nvim ~/.dotfiles_backup/nvim.config.bak
  fi
  ln -sfn /usr/local/dotfiles/nvim ~/.config/nvim
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
  setupSudoAskpass
  rsync -avh --ignore-times --no-perms --progress bash_dot_files/ $HOME
  rsync -avh --ignore-times --no-perms --progress bin/ $HOME/bin
  setupSettings
  source ~/.bash_profile
}

function setupMise() {
  mkdir -p ~/.config/mise
  rsync -avh --ignore-times --no-perms --progress \
    /usr/local/dotfiles/the_dot_files/.config/mise/ ~/.config/mise/
  mise install
  rm -f ~/.asdfrc ~/.tool-versions
  rm -rf ~/.asdf
  rm -rf ~/.rvm
  echo "✓ mise tools installed, asdf/rvm artifacts removed"
}

function setupDotfiles() {
  rsync -avh --ignore-times --no-perms --progress \
    --exclude='.vimrc' --exclude='.tmux.conf' \
    --exclude='.claude' --exclude='.claude.json' \
    /usr/local/dotfiles/the_dot_files/ $HOME
  # sqls config (only written if not already present — preserves local DB connections)
  mkdir -p ~/.config/sqls
  if [[ ! -f ~/.config/sqls/config.yml ]]; then
    cp /usr/local/dotfiles/the_dot_files/.config/sqls/config.yml ~/.config/sqls/config.yml
    echo "✓ sqls config written to ~/.config/sqls/config.yml"
  else
    echo "✓ sqls config already exists, skipping"
  fi
  echo "✓ Dotfiles rsynced"
}

function setupClaude() {
  mkdir -p ~/.claude
  ln -sf /usr/local/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
  ln -sf /usr/local/dotfiles/claude/statusline-command.sh ~/.claude/statusline-command.sh
  echo "✓ Claude symlinks created"
}

function setupAll() {
  echo " *** Full Mac Bootstrap ***"
  setupSudoAskpass
  setupHomebrew
  setupDotfiles
  setupClaude
  setupMise
  setupZsh
  # Symlinks must come after setupZsh: the oh-my-zsh installer replaces
  # ~/.zshrc with a plain file, clobbering the symlink.
  setupDotfileSymlinks
  setupVim
  setupTmux
}

function setupZsh() {
  if [[ -f /opt/homebrew/bin/zsh ]]; then
    grep -qxF /opt/homebrew/bin/zsh /etc/shells || echo "/opt/homebrew/bin/zsh" | sudo tee -a /etc/shells
    chsh -s /opt/homebrew/bin/zsh
    sudo ln -sf /opt/homebrew/bin/zsh /usr/local/bin/zsh
  elif [[ -f /usr/local/bin/zsh ]]; then
    grep -qxF /usr/local/bin/zsh /etc/shells || echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
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
  # Neovim: symlink config and sync plugins headlessly.
  # (.vimrc stays rsynced for Ubuntu/Synology; macOS uses nvim.)
  mkdir -p ~/.config
  if [[ -d ~/.config/nvim && ! -L ~/.config/nvim ]]; then
    mkdir -p ~/.dotfiles_backup
    mv ~/.config/nvim ~/.dotfiles_backup/nvim.config.bak
  fi
  ln -sfn /usr/local/dotfiles/nvim ~/.config/nvim
  nvim --headless "+Lazy! sync" +qa
  echo "✓ Neovim plugins synced"
  nvim --headless "+MasonUpdate" +qa
  echo "✓ Mason LSP packages updated"
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
  npm install -g eslint_d fx markdownlint-cli prettier
  while getopts ":abchdmoltsvz" opt; do
    case $opt in
      a)
        echo " *** Full Mac Bootstrap ***"
        setupAll
        ;;
      b)
        echo " *** Bootstrap Bash ***"
        setupBash
        ;;
      c)
        echo " *** Bootstrap Claude ***"
        setupClaude
        ;;
      d)
        echo " *** Sync dotfiles ***"
        setupDotfiles
        ;;
      m)
        echo " *** Bootstrap mise ***"
        setupMise
        ;;
      h)
        echo " *** Bootstrap Homebrew ***"
        setupHomebrew
        ;;
      o)
        echo " *** Bootstrap macOS ***"
        ./bootstrap_macos.sh $2
        setupHomebrew
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
        echo " *** Bootstrap neovim ***"
        setupVim
        ;;
      z)
        echo " *** Bootstrap zsh ***"
        setupZsh
        ;;
    esac
  done
fi;

unset setupAll;
unset setupBash;
unset setupClaude;
unset setupDotfiles;
unset setupDotfileSymlinks;
unset setupMise;
unset setupHomebrew;
unset setupSettings;
unset setupSudoAskpass;
unset setupTmux;
unset setupVim;
unset setupZsh;
