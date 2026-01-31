# Barrett’s dotfiles

This is originally based on [mathias's dotfiles](mathiasbynens/dotfiles), and is an eternal work in progress.

<!-- vim-markdown-toc GFM -->

* [Installation](#installation)
  * [Installing a fresh Mac](#installing-a-fresh-mac)
  * [Linux Setup](#linux-setup)
  * [Linux From Scratch](#linux-from-scratch)
    * [Install Sudo](#install-sudo)
    * [Run Installer Script](#run-installer-script)
* [Credits](#credits)

<!-- vim-markdown-toc -->

## Installation

There is a main bootstrap script (`bootstrap.sh`) that does all the bootstrapping. You pass it options as follows:

```bash
./bootstrap.sh -b -f -h -o -l -s -t -v -z
```

Any or many of the options can be passed in. The options are as follows:

```
* -b = bash shell
* -f = fish shell
* -h = Homebrew
* -o = OSX (and Homebrew)
* -l = linux
* -s = symlink dotfiles (.zshrc, .vimrc, .tmux.conf)
* -t = tmux
* -v = vim
* -z = zsh
```

**Note:** Primary dotfiles (`.zshrc`, `.vimrc`, `.tmux.conf`) are now **symlinked** to the repo instead of copied. This means:
- Edits to `~/.zshrc` edit the repo version automatically
- Changes are tracked in git
- Easy to deploy to multiple machines
- Single source of truth

To manually create symlinks on an existing setup:
```bash
./bootstrap.sh -s
```

### Installing a fresh Mac

This will install general dotfiles, zsh, vim, tmux, OSX things.

* Setup an SSH key with GitHub
* Clone the dotfiles into `/usr/local/dotfiles`
  * First change the owner of `/usr/local` to your user
  * The first time you run the `git` command it will ask to install the command line tools. No need to install Xcode!
* Install 1Password in Safari
* Bootstrap ALLTHETHINGS `/usr/local/dotfiles/bootstrap.sh -votz [NAME]`
  * I have started using wine varieties for computer names
* Install App Store purchases

**Current zsh config notes:**
- Using `fast-syntax-highlighting` (not the slower `zsh-syntax-highlighting`)
- Using `zsh-autosuggestions` (not the aggressive `zsh-autocomplete`)
- Removed `rake-fast` plugin (not needed for non-Ruby work)
- Bash aliases are sourced for cross-shell compatibility
- Terraform abbreviations included (`tfi`, `tfp`, `tfa`, etc.)

### Linux Setup

I also use a Linux box from time to time, so here is how I bootstrap that puppy:

```bash
./bootstrap_linux.sh
```

### Linux From Scratch

On a brand new Linux install you probably won't have `git` installed, and may not even have `sudo` installed.

#### [Install Sudo](https://unix.stackexchange.com/a/425664)

Enable su-mode:

```
su -
```

Install sudo:

```
apt-get install sudo -y
```

Enable sudo for your user:

```
usermod -aG sudo yourusername
```

Finally, you need to log out and log back in.

#### Run Installer Script

Now you can run the installer script from GitHub. Trust me, it's fiiiiine.

```
wget -O - https://raw.githubusercontent.com/barrettclark/dotfiles/master/bootstrap_linux.sh | bash
```

### Synology NAS Setup

For Synology NAS devices running DSM - sets up zsh and vim only (tmux not included).

**Prerequisites:**
1. Install packages via Synology Package Center:
   - Git Server (for git)
   - Text Editor (includes vim)
2. Enable SSH in Control Panel > Terminal & SNMP

**Setup:**
1. SSH into your Synology
2. Clone the dotfiles to your home directory:
   ```bash
   cd ~
   git clone https://github.com/barrettclark/dotfiles.git
   cd dotfiles
   ```

3. Run the Synology bootstrap:
   ```bash
   ./bootstrap_synology.sh
   ```

4. Log out and back in - zsh will start automatically
   - Or start using zsh now: `exec zsh`

**What gets installed:**
- oh-my-zsh with plugins (autosuggestions, fast-syntax-highlighting)
- vim with vim-plug and all configured plugins
- Symlinks to dotfiles from ~/dotfiles
- Auto-start zsh via .profile (safer than changing /etc/passwd)

**How it works:**
The bootstrap adds zsh auto-start to your `.profile` instead of modifying `/etc/passwd`. This means:
- zsh starts automatically on login
- If zsh breaks, you can still log in with sh and fix it
- No risk of being locked out of your NAS

**Known limitations:**
- `zsh-abbr` won't work (requires Homebrew) - abbreviations won't expand
- Some vim plugins may not work (language servers require additional setup)
- Starship prompt requires separate installation
- tmux not included (install manually if needed)

## Credits

Initial dotfiles forked from mathiasbynens/dotfiles
Fish functions from nvie/dotfiles
