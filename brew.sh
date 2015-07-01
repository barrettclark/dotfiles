#!/usr/bin/env bash

# Install developer tools
# xcode-select --install

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew tap homebrew/versions
brew install bash-completion

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
# brew install homebrew/php/php55 --with-gmp

# Install other useful binaries.
brew install ack
brew install dark-mode
#brew install exiv2
brew install git
brew install git-lfs
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
# brew install rhino
brew install speedtest_cli
brew install ssh-copy-id
brew install tree
brew install webkit2png
brew install zopfli

# The things I like that were not already listed
brew install curl
brew install ctags
brew install node
brew install npm
brew install cloc
brew install sqlite
brew install redis
brew install todo-txt
brew install heroku-toolbelt
brew install tmux
brew install memcached
brew install bash-git-prompt
brew install carthage
brew install cowsay
brew install fortune
brew install gradle
brew install highlight
brew install mosquitto
brew install readline
brew install go
brew install scala
brew install elixir

# Symlink things maybe
brew linkapps

# Cask to install binaries
brew install caskroom/cask/brew-cask

# system things
brew cask install pusher
brew cask install growlnotify
brew cask install launchrocket
brew cask install caffeine
brew cask install charles
brew cask install controlplane
brew cask install istat-menus
brew cask install sizeup

# dev things
brew cask install java
brew cask install android-studio
brew cask install intellij-idea
brew cask install charles
brew cask install colloquy
brew cask install controlplane
brew cask install dash
brew cask install gitx
brew cask install sublime-text
brew cask install pgadmin3
brew cask install postgres
brew cask install sequel-pro
# brew cask install virtualbox
# brew cask install vagrant
brew cask install firefox
brew cask install google-chrome

# general things
brew cask install disk-inventory-x
brew cask install dropbox
brew cask install get-lyrical
brew cask install screenhero
brew cask install slack

# Remove outdated versions from the cellar.
brew cleanup
brew cleanup -s --force
brew cask cleanup
