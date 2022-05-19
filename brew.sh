#!/usr/bin/env bash

# Install developer tools
# xcode-select --install

# Install command-line tools using Homebrew.

# Install homebrew
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Move git hooks out of the way if they exist so they don't interfere
# with Homebrew updating it's repo.
if [ -d "~/.git-templates/hooks" ]; then
  mv ~/.git-templates/hooks ~/.git-templates/hooks.bak
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Run brew bundle to install things
brew bundle --verbose --file=/usr/local/dotfiles/Brewfile

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
if [ ! -f "/usr/local/bin/sha256sum" ]; then
  sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum
fi

# Upgrade MacOS applications
mas upgrade

# Remove outdated versions from the cellar.
brew cleanup
brew cleanup -s

if [ -d "~/.git-templates/hooks.bak" ]; then
  mv ~/.git-templates/hooks.bak ~/.git-templates/hooks
fi
