#!/usr/bin/env bash

#
# NOTE: This is being replaced with the Brewfile
#

# Install developer tools
# xcode-select --install

# Install command-line tools using Homebrew.

# Install homebrew
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

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
brew install bash fish
brew tap homebrew/versions
brew install bash-completion

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
# brew install homebrew/dupes/screen
# brew install homebrew/php/php55 --with-gmp

# Install other useful things.
brew install ack
#brew install dark-mode
#brew install exiv2
brew install gpg
brew install git
brew install git-lfs
brew install imagemagick --with-webp
brew install jq
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install python
brew install rename
# brew install rhino
brew install speedtest_cli
brew install ssh-copy-id
brew install tree
brew install webkit2png
brew install zopfli
brew install cmake
brew install mono

# The things I like that were not already listed
brew install curl
brew install ctags
brew install node
brew install npm
# brew install nvm
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
# brew install docker docker-machine docker-compose
brew install reattach-to-user-namespace
brew install tidy-html5
brew install r
brew install mas

# Symlink things maybe
brew linkapps

# Cask to install binaries
if [ ! -d "ls /usr/local/Caskroom" ]; then
  brew tap caskroom/cask
fi
brew upgrade brew-cask
brew cask update

# system things
brew cask install caffeine
brew cask install controlplane
brew cask install growlnotify
brew cask install istat-menus
# brew cask install caskroom/homebrew-versions/java6
brew cask install java
brew cask install launchrocket
brew cask install pusher
# brew cask install sizeup
brew cask install squidman

# fonts
brew tap caskroom/fonts
brew cask install font-open-sans
brew cask install font-roboto
brew cask install font-source-code-pro
brew cask install font-hack

# dev things
# brew cask install vagrant
brew cask install android-studio
brew cask install charles
brew cask install colloquy
# echo "Install Dash from the App Store"
brew cask install dash
brew cask install firefox
brew cask install rowanj-gitx
brew cask install google-chrome
brew cask install google-cloud-sdk
brew cask install intellij-idea-ce
brew cask install pgadmin4
brew cask install postgres
brew cask install rstudio
brew cask install sequel-pro
brew cask install sublime-text
brew cask install virtualbox
brew cask install macdown
brew cask install docker
brew cask install kitematic
# brew cask install visual-studio-code

# general things
brew cask install disk-inventory-x
brew cask install dropbox
brew cask install evernote
brew cask install get-lyrical
brew cask install screenhero
brew cask install slack
brew cask install mojibar
brew cask install keycastr
brew cask install gimp

# Remove outdated versions from the cellar.
brew cleanup
brew cleanup -s --force
brew cask cleanup
