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
mv ~/.git-templates/hooks ~/.git-templates/hooks.bak
brew tap heroku/brew
brew update

# Upgrade any already-installed formulae.
brew upgrade

/usr/bin/env ruby <<-EORUBY
  packages = [
    "ack",
    "ansible",
    "ansifilter",
    "asdf",
    "awscli",
    "bash",
    "bash-completion",
    "bash-git-prompt",
    "bat",
    "cloc",
    "cmake",
    "consul",
    "consul-template",
    "coreutils",
    "cowsay",
    "ctags",
    "curl",
    "dbus",
    "dep",
    "enscript",
    "exercism",
    "findutils",
    "fish",
    "fortune",
    "fpp",
    "freetds",
    "fzf",
    "gawk",
    "geckodriver",
    "git",
    "git-lfs",
    "git-standup",
    "gnu-indent",
    "gnu-sed --with-default-names",
    "gnu-tar",
    "gnu-which",
    "gnupg",
    "go",
    "golangci-lint",
    "gpp",
    "gradle",
    "graphicsmagick",
    "graphviz",
    "grep",
    "gtk+",
    "heroku",
    "hey",
    "highlight",
    "jenv",
    "jq",
    "leiningen",
    "libxml2",
    "lolcat",
    "lua",
    "lynx",
    "markdown",
    "mas",
    "maven",
    "memcached",
    "mkcert",
    "moreutils",
    "mosquitto",
    "netcat",
    "ngrok",
    "node",
    "nomad",
    "npm",
    "openssh",
    "p7zip",
    "pandoc",
    "pv",
    "python3",
    "qmk/qmk/qmk",
    "rainbarf",
    "readline",
    "reattach-to-user-namespace",
    "redis",
    "rename",
    "rlwrap",
    "rpm",
    "shared-mime-info",
    "sl",
    "speedtest-cli",
    "sqlite",
    "ssh-copy-id",
    "svn",
    "terraform",
    "tidy-html5",
    "tmux",
    "tmux-mem-cpu-load",
    "todo-txt",
    "tree",
    "urlview",
    "vault",
    "vim --override-system-vi",
    "webkit2png",
    "wget --with-iri",
    "yarn",
    "zopfli"
  ]
  installed  = %x(brew list --formula).split("\n")
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
  brew tap AdoptOpenJDK/openjdk
  brew tap homebrew/cask
  brew tap homebrew/cask-fonts
  brew tap homebrew/cask-drivers
fi

/usr/bin/env ruby <<-EORUBY
  casks = [
    "1password",
    "1password-cli",
    "adoptopenjdk",
    "caffeine",
    "charles",
    "chromedriver",
    "corelocationcli",
    "discord",
    "disk-inventory-x",
    "docker",
    "dropbox",
    "firefox",
    "font-consolas-for-powerline",
    "font-droid-sans-mono-for-powerline",
    "font-hack",
    "font-hack-nerd-font",
    "font-inconsolata-dz-for-powerline",
    "font-inconsolata-for-powerline",
    "font-open-sans",
    "font-roboto",
    "font-source-code-pro",
    "gimp",
    "google-chrome",
    "intellij-idea-ce",
    "istat-menus",
    "kitematic",
    "macdown",
    "mtmr",
    "pocket-casts",
    "postman",
    "qmk-toolbox",
    "quicklook-json",
    "r",
    "rowanj-gitx",
    "rstudio",
    "sequel-pro",
    "slack",
    "spotify",
    "sublime-text",
    "todotxt",
    "vagrant",
    "virtualbox",
    "visual-studio-code",
    "wkhtmltopdf",
    "zoom"
  ]
  installed  = %x(brew list --cask).split("\n")
  to_install = casks - installed
  p to_install unless to_install.empty?
  to_install.each { |cask| system("brew install --cask #{cask}") }
EORUBY

# Remove outdated versions from the cellar.
brew cleanup
brew cleanup -s
mv ~/.git-templates/hooks.bak ~/.git-templates/hooks
