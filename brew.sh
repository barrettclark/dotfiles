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
    "gnu-sed --with-default-names",
    "gnupg",
    "go",
    "gpp",
    "gradle",
    "graphicsmagick",
    "graphviz",
    "grep",
    "gtk+",
    "heroku",
    "hey",
    "highlight",
    "jq",
    "leiningen",
    "libxml2",
    "lolcat",
    "lua",
    "lynx",
    "mas",
    "maven",
    "memcached",
    "mkcert",
    "moreutils",
    "mosquitto",
    "netcat",
    "node",
    "openssh",
    "p7zip",
    "pandoc",
    "pv",
    "python",
    "r",
    "rainbarf",
    "readline",
    "reattach-to-user-namespace",
    "redis",
    "rename",
    "rlwrap",
    "rpm",
    "sl",
    "speedtest-cli",
    "sqlite",
    "ssh-copy-id",
    "terraform",
    "tidy-html5",
    "tmux",
    "tmux-mem-cpu-load",
    "todo-txt",
    "tomcat",
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
  brew tap caskroom/cask
  brew tap caskroom/cask-fonts
fi

/usr/bin/env ruby <<-EORUBY
  casks = [
    "1password-cli",
    "caffeine",
    "charles",
    "chromedriver",
    "corelocationcli",
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
    "get-lyrical",
    "gimp",
    "google-chrome",
    "intellij-idea",
    "istat-menus",
    # "java",
    "kitematic",
    "launchrocket",
    "macdown",
    "pocket-casts",
    "postgres",
    "postman",
    "quicklook-json",
    "rowanj-gitx",
    "rstudio",
    "sequel-pro",
    "slack",
    "spotify",
    "spotify-notifications",
    "sublime-text",
    "todotxt",
    "vagrant",
    "virtualbox",
    "visual-studio-code",
    "wkhtmltopdf"
  ]
  installed  = %x(brew list --cask).split("\n")
  to_install = casks - installed
  p to_install unless to_install.empty?
  to_install.each { |cask| system("brew cask install #{cask}") }
EORUBY

# Remove outdated versions from the cellar.
brew cleanup
brew cleanup -s
mv ~/.git-templates/hooks.bak ~/.git-templates/hooks
