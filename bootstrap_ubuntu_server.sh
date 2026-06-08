#!/usr/bin/env bash

#==============================================================================
# Ubuntu Server 24 Bootstrap
# Server-focused setup for zsh, vim, and tmux (no Homebrew, no GUI tools)
# Designed for headless servers like arr-stack and database hosts
#==============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Dotfiles directory: $DOTFILES_DIR"

# Check if running on Ubuntu/Debian
if ! command -v apt-get >/dev/null 2>&1; then
  echo "ERROR: This script requires apt-get (Ubuntu/Debian)"
  exit 1
fi

#==============================================================================
# Functions
#==============================================================================

function install_packages() {
  echo "Updating apt and installing packages..."
  sudo apt-get -qq -y update
  sudo apt-get -qq -y dist-upgrade
  sudo apt-get -qq -y install --fix-missing \
    build-essential \
    cmake \
    curl \
    fzf \
    git \
    htop \
    jq \
    net-tools \
    openssh-server \
    ripgrep \
    tmux \
    tree \
    unzip \
    vim \
    wget \
    zsh
  sudo apt-get -qq -y autoremove
  echo "✓ Packages installed"
}

function install_starship() {
  if command -v starship >/dev/null 2>&1; then
    echo "✓ Starship already installed"
    return
  fi
  echo "Installing Starship prompt..."
  curl -sS https://starship.rs/install.sh | sh -s -- --yes
  echo "✓ Starship installed"
}

function setup_dotfiles_dir() {
  echo "Setting up dotfiles directory at $DOTFILES_DIR..."

  # Initialize submodules if not already done
  cd "$DOTFILES_DIR"
  git submodule update --init --recursive
  echo "✓ Git submodules initialized"
}

function setup_zsh() {
  echo "Setting up zsh..."

  # Install oh-my-zsh if not present
  if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi

  # Install zsh plugins
  echo "Installing zsh plugins..."

  if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  fi

  if [ ! -d ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting ]; then
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
  fi

  # Symlink .zshrc
  if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
    echo "Backed up existing .zshrc"
  fi
  ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
  echo "✓ Symlinked .zshrc"

  # Set zsh as default shell
  ZSH_PATH="$(which zsh)"
  if ! grep -qF "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells
  fi
  if [ "$SHELL" != "$ZSH_PATH" ]; then
    chsh -s "$ZSH_PATH"
    echo "✓ Default shell set to zsh (takes effect on next login)"
  else
    echo "✓ zsh is already the default shell"
  fi
}

function setup_vim() {
  echo "Setting up vim..."

  # Backup existing .vimrc
  if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.backup.$(date +%Y%m%d_%H%M%S)
    echo "Backed up existing .vimrc"
  fi

  # Install vim-plug
  if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo "Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  # Sync vim colors and syntax
  rsync -avh --ignore-times --no-perms --progress "$DOTFILES_DIR/.vim/colors/" ~/.vim/colors/
  rsync -avh --ignore-times --no-perms --progress "$DOTFILES_DIR/.vim/syntax/" ~/.vim/syntax/

  # Symlink .vimrc
  ln -sf "$DOTFILES_DIR/the_dot_files/.vimrc" ~/.vimrc
  echo "✓ Symlinked .vimrc"

  # Install vim plugins (headless)
  echo "Installing vim plugins (this may take a minute)..."
  vim +PlugInstall +qall
  echo "✓ Vim plugins installed"
}

function setup_tmux() {
  echo "Setting up tmux..."

  # Backup existing .tmux.conf
  if [ -f ~/.tmux.conf ]; then
    mv ~/.tmux.conf ~/.tmux.conf.backup.$(date +%Y%m%d_%H%M%S)
    echo "Backed up existing .tmux.conf"
  fi

  # Install TPM
  if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  # Symlink .tmux.conf
  ln -sf "$DOTFILES_DIR/the_dot_files/.tmux.conf" ~/.tmux.conf
  echo "✓ Symlinked .tmux.conf"
  echo "  Note: Run tmux then press prefix + I to install tmux plugins"
}

function setup_other_dotfiles() {
  echo "Syncing other dotfiles..."
  rsync -avh --ignore-times --no-perms --progress \
    --exclude='.vimrc' \
    --exclude='.tmux.conf' \
    --exclude='.claude' \
    --exclude='.claude.json' \
    "$DOTFILES_DIR/the_dot_files/" "$HOME/"
  rsync -avh --ignore-times --no-perms --progress \
    "$DOTFILES_DIR/bash_dot_files/" "$HOME/"
  rsync -avh --ignore-times --no-perms --progress \
    "$DOTFILES_DIR/bin/" "$HOME/bin/"
  echo "✓ Other dotfiles synced"
}

function install_mise() {
  if command -v mise >/dev/null 2>&1 || [ -f "$HOME/.local/bin/mise" ]; then
    echo "✓ mise already installed"
  else
    echo "Installing mise..."
    curl https://mise.run | sh
    echo "✓ mise installed"
  fi
  "$HOME/.local/bin/mise" install
  rm -f ~/.asdfrc ~/.tool-versions
  rm -rf ~/.asdf
  echo "✓ mise tools installed, asdf artifacts removed"
}

#==============================================================================
# Main
#==============================================================================

echo "Ubuntu Server Dotfiles Bootstrap"
echo "================================="
echo ""

read -p "This will install packages and overwrite dotfiles. Continue? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Cancelled."
  exit 0
fi

# Keep sudo alive
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
SUDO_PID=$!
trap "kill $SUDO_PID 2>/dev/null" EXIT

install_packages
install_starship
setup_dotfiles_dir
setup_zsh
setup_vim
setup_tmux
setup_other_dotfiles
install_mise

echo ""
echo "✓ Bootstrap complete!"
echo ""
echo "Next steps:"
echo "  1. Log out and back in - zsh will start automatically"
echo "  2. Or start using zsh now: exec zsh"
echo "  3. In tmux, press prefix + I to install tmux plugins"
echo "  4. Run 'mise list' to verify installed tools"
echo ""
echo "Known limitations on Ubuntu Server:"
echo "  - No zsh-abbr (requires Homebrew) - abbreviations won't expand"
echo "  - Some vim plugins may not work (language servers require additional setup)"
echo "  - Weather script in tmux requires curl and location config"
echo ""
