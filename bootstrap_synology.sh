#!/usr/bin/env bash

#==============================================================================
# Synology NAS Bootstrap
# Minimal setup for zsh, vim, and tmux on Synology DSM
#==============================================================================

# Detect dotfiles location (Synology home dirs are usually /volume1/homes/username)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Dotfiles directory: $DOTFILES_DIR"

# Check if running on Synology
if [ ! -f /etc/synoinfo.conf ]; then
  echo "Warning: This doesn't appear to be a Synology system"
  read -p "Continue anyway? (y/n) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
fi

#==============================================================================
# Functions
#==============================================================================

function setup_zsh() {
  echo "Setting up zsh..."

  # Install oh-my-zsh if not present
  if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi

  # Install zsh plugins
  echo "Installing zsh plugins..."

  if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-git-prompt ]; then
    git clone https://github.com/zsh-git-prompt/zsh-git-prompt.git ~/.oh-my-zsh/custom/plugins/zsh-git-prompt
  fi

  if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  fi

  if [ ! -d ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting ]; then
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
  fi

  # Note: zsh-abbr won't work without Homebrew, so we'll skip it on Synology
  # The abbreviations in .zshrc won't expand, but the config will still work

  # Create symlink to .zshrc
  if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
    echo "Backed up existing .zshrc"
  fi
  ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc
  echo "✓ Symlinked .zshrc"
}

function setup_vim() {
  echo "Setting up vim..."

  # Create backup if .vimrc exists
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

  # Symlink .vimrc
  ln -sf "$DOTFILES_DIR/the_dot_files/.vimrc" ~/.vimrc
  echo "✓ Symlinked .vimrc"

  # Install vim plugins
  echo "Installing vim plugins (this may take a minute)..."
  vim +PlugInstall +qall
  echo "✓ Vim plugins installed"
}


function setup_auto_zsh() {
  echo "Setting up auto-start zsh in .profile..."

  # Add zsh auto-start to .profile (safer than changing /etc/passwd)
  if ! grep -q "exec /usr/local/bin/zsh" ~/.profile 2>/dev/null; then
    cat >> ~/.profile <<'EOF'

# Auto-start zsh if it exists and we're in an interactive shell
# This is safer than changing /etc/passwd on Synology
if [ -n "$PS1" ] && [ -x /usr/local/bin/zsh ]; then
  export SHELL=/usr/local/bin/zsh
  exec /usr/local/bin/zsh
fi
EOF
    echo "✓ Added zsh auto-start to .profile"
  else
    echo "✓ .profile already configured for zsh"
  fi
}

function setup_bash_aliases() {
  echo "Setting up bash aliases..."

  # Create a minimal bashrc that sources aliases
  if ! grep -q "bash_dot_files/.bash_aliases" ~/.bashrc 2>/dev/null; then
    cat >> ~/.bashrc <<'EOF'

# Load dotfiles bash aliases
if [ -f "$HOME/dotfiles/bash_dot_files/.bash_aliases" ]; then
  source "$HOME/dotfiles/bash_dot_files/.bash_aliases"
fi
EOF
    echo "✓ Added bash aliases to .bashrc"
  fi
}

function check_dependencies() {
  echo "Checking dependencies..."

  local missing=()

  command -v git >/dev/null 2>&1 || missing+=("git")
  command -v curl >/dev/null 2>&1 || missing+=("curl")
  command -v vim >/dev/null 2>&1 || missing+=("vim")
  command -v zsh >/dev/null 2>&1 || missing+=("zsh")

  if [ ${#missing[@]} -ne 0 ]; then
    echo "ERROR: Missing required packages: ${missing[*]}"
    echo "Install them via Synology Package Center or SSH:"
    echo "  - git, vim, zsh should be available in Community packages"
    exit 1
  fi

  echo "✓ All dependencies found"
}

#==============================================================================
# Main
#==============================================================================

echo "Synology NAS Dotfiles Bootstrap"
echo "================================"
echo ""

check_dependencies

echo ""
read -p "This will setup zsh and vim. Continue? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Cancelled."
  exit 0
fi

# Setup zsh
setup_zsh

# Setup vim
setup_vim

# Setup auto-start zsh on login
setup_auto_zsh

# Setup bash aliases
setup_bash_aliases

echo ""
echo "✓ Bootstrap complete!"
echo ""
echo "Next steps:"
echo "  1. Log out and back in - zsh will start automatically"
echo "  2. Or start using zsh now: exec zsh"
echo ""
echo "How it works:"
echo "  - .profile automatically starts zsh on login (safer than changing /etc/passwd)"
echo "  - If zsh breaks, you can still log in with sh and fix it"
echo ""
echo "Known limitations on Synology:"
echo "  - No zsh-abbr (requires Homebrew) - abbreviations won't expand"
echo "  - Some vim plugins may not work (gopls, language servers, etc.)"
echo "  - Starship prompt requires separate installation"
echo "  - Weather script in tmux config references /usr/local/dotfiles"
echo ""
echo "Note: tmux not included. If you need it, install via Package Center and"
echo "      manually symlink: ln -sf $DOTFILES_DIR/the_dot_files/.tmux.conf ~/.tmux.conf"
echo ""
