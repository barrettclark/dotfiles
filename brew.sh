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

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

brew tap codeclimate/formulae

/usr/bin/env ruby <<-EORUBY
  packages = [
    "ack",
    "ansifilter",
    "bash",
    "bash-completion",
    "bash-git-prompt",
    "carthage",
    "chromedriver",
    "cloc",
    "cmake",
    "coreutils",
    "cowsay",
    "ctags",
    "curl",
    "exercism",
    "findutils",
    "fish",
    "fortune",
    "fpp",
    "freetds",
    "fzf",
    "geckodriver",
    "git",
    "git-lfs",
    "gnu-sed --with-default-names",
    "gnupg",
    "go",
    "gradle",
    "graphviz",
    "grep",
    "gtk+",
    "heroku",
    "highlight",
    "jq",
    "libxml2",
    "lolcat",
    "lua",
    "lynx",
    "mas",
    "memcached",
    "moreutils",
    "mosquitto",
    "node",
    "openssh",
    "p7zip",
    "pv",
    "python",
    "r",
    "readline",
    "reattach-to-user-namespace",
    "redis",
    "rename",
    "rlwrap",
    "speedtest-cli",
    "sqlite",
    "ssh-copy-id",
    "tidy-html5",
    "tmux",
    "tmux-mem-cpu-load",
    "todo-txt",
    "tree",
    "vim --override-system-vi",
    "webkit2png",
    "wget --with-iri",
    "yarn",
    "zopfli"
  ]
  installed  = %x(brew list).split("\n")
  names      = packages.map { |package| package.split(' ').first }
  diff       = names - installed
  to_install = diff.each { |name| packages.grep(/name/).first }.uniq
  p to_install unless to_install.empty?
  to_install.each { |package| system("brew install #{package}") }
EORUBY

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Cask to install binaries
if [ ! -d "/usr/local/Caskroom" ]; then
  brew tap caskroom/cask
fi
brew tap caskroom/fonts

/usr/bin/env ruby <<-EORUBY
  casks = [
    "caffeine",
    "charles",
    "dash",
    "disk-inventory-x",
    "docker",
    "dropbox",
    "firefox",
    "flowdock",
    "font-hack",
    "font-hack-nerd-font",
    "font-open-sans",
    "font-roboto",
    "font-source-code-pro",
    "get-lyrical",
    "gimp",
    "google-chrome",
    "hermes",
    "istat-menus",
    "java",
    "kitematic",
    "lastpass",
    "launchrocket",
    "macdown",
    "mojibar",
    "pgadmin4",
    "pocket-casts",
    "postgres",
    "postman",
    "rowanj-gitx",
    "rstudio",
    "screenhero",
    "sequel-pro",
    "slack",
    "spotify",
    "sublime-text",
    "virtualbox"
  ]
  installed  = %x(brew cask list).split("\n")
  to_install = casks - installed
  p to_install unless to_install.empty?
  to_install.each { |cask| system("brew cask install #{cask}") }
EORUBY

# Remove outdated versions from the cellar.
brew cleanup
brew cleanup -s --force
brew cask cleanup
