# Barrett’s dotfiles

This is originally based on [mathias's dotfiles](mathiasbynens/dotfiles), and is an eternal work in progress.

## Installation

There is a main bootstrap script (`bootstrap.sh`) that does all the bootstrapping. You pass it options as follows:

```bash
./bootstrap.sh -b -f -h -o -l -t -v
```

Any or many of the options can be passed in. The options are as follows:
```
* -b = bash shell
* -f = fish shell
* -h = Homebrew
* -o = OSX (and Homebrew)
* -l = linux
* -t = tmux
* -v = vim
```

### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./bootstrap_osx.sh
```

### Install Homebrew formulae

When setting up a new Mac, you may want to install some common [Homebrew](http://brew.sh/) formulae (after installing Homebrew, of course):

```bash
./brew.sh
```

### Linux Setup

I also use a Linux box from time to time, so here is how I bootstrap that puppy:

```bash
./bootstrap_linux.sh
```

## Credits

Initial dotfiles forked from mathiasbynens/dotfiles
Fish functions from nvie/dotfiles
