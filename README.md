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

### Installing a fresh Mac

This will install general dotfiles, fish, vim, tmux, OSX things.

* Setup an SSH key with GitHub
* Clone the dotfiles into `/usr/local/dotfiles`
	* First change the owner of `/usr/local` to your user
	* The first time you run the `git` command it will ask to install the command line tools. No need to install Xcode!
* Install LastPass in Safari
* Bootstrap ALLTHETHINGS `/usr/local/dotfiles/bootstrap.sh -votf [NAME]`
	* I have started using wine varieties for computer names
* Install App Store purchases

### Linux Setup

I also use a Linux box from time to time, so here is how I bootstrap that puppy:

```bash
./bootstrap_linux.sh
```

## Credits

Initial dotfiles forked from mathiasbynens/dotfiles
Fish functions from nvie/dotfiles
