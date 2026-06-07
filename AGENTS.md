# AGENTS.md — barrettclark/dotfiles

Personal dotfiles for Barrett Clark (barrett.clark@hashicorp.com). Shell, vim, tmux, macOS defaults, Homebrew packages, utility scripts.

## Repo anatomy

| Path | Purpose |
|------|---------|
| `zsh/.zshrc` | Zsh config — **symlinked** to `~/.zshrc` |
| `the_dot_files/.vimrc` | Vim config — **symlinked** to `~/.vimrc` |
| `the_dot_files/.tmux.conf` | Tmux config — **symlinked** to `~/.tmux.conf` |
| `the_dot_files/` | Remaining dotfiles — **rsynced** (copied) to `$HOME` |
| `bash_dot_files/` | Bash config, aliases, exports, functions |
| `bin/` | Utility scripts deployed to `~/bin/` |
| `zsh/functions/` | Autoloaded zsh functions (16 items) |
| `the_dot_files/.tmuxp/` | Tmuxp session layouts (dotfiles, terraform, etc.) |
| `the_dot_files/.config/mise/` | Mise runtime version config |
| `fonts/` | Patched Powerline/Nerd fonts |

On Mac/Ubuntu, dotfiles live at `/usr/local/dotfiles`. On Synology, `~/dotfiles`. Shell auto-detects via `zsh/.zshrc:162-166`.

## Bootstrap

Six scripts, one per platform:

| Script | Target |
|--------|--------|
| `bootstrap.sh -a` | Full Mac (Homebrew → dotfiles → symlinks → mise → zsh → vim → tmux) |
| `bootstrap.sh -s` | Symlinks only (`.zshrc`, `.vimrc`, `.tmux.conf`) |
| `bootstrap.sh -d` | Rsync dotfiles only |
| `bootstrap_macos.sh` | macOS defaults + computer name (takes name arg, wine varieties) |
| `bootstrap_ubuntu_server.sh` | Headless Ubuntu 24 (zsh, vim, tmux, mise, starship) |
| `bootstrap_synology.sh` | Synology DSM (zsh, vim via .profile — no /etc/passwd changes) |

Flags for `bootstrap.sh`: `-a` (all), `-b` (bash), `-d` (dotfiles), `-h` (Homebrew), `-m` (mise), `-o` (OSX defaults), `-l` (linux), `-s` (symlinks), `-t` (tmux), `-v` (vim), `-z` (zsh).

## Submodules

```sh
git submodule update --init --recursive
```

- `.tmux/` — barrettclark/.tmux (tmux config with local overrides)
- `zsh/myth-prompt-themes/` — barrettclark/myth-prompt-themes (Starship prompt theme)

## Shell quirks

- **zsh-abbr** is Homebrew-only (`olets/tap/zsh-abbr`). Abbreviations won't expand on Linux or Synology.
- Uses **fast-syntax-highlighting** (not `zsh-syntax-highlighting`), **zsh-autosuggestions** (not `zsh-autocomplete`).
- Bash aliases sourced cross-shell from `bash_dot_files/.bash_aliases`.
- Starship prompt config lives in the `myth-prompt-themes` submodule.
- Terraform abbreviations via zsh-abbr: `tfi`, `tfp`, `tfa`, `tfv`, `tfw`, `tfo`, `tfs`, `tfsh`, `tfd`.
- `git-master-or-main` zsh function (`zsh/functions/git-master-or-main`) auto-detects default branch name.
- Computer names follow wine varieties (e.g. `bootstrap_macos.sh pinot-noir`).

## Vim

`.vimrc` uses **vim-plug** (`Plug '...'`). On Mac, `bootstrap.sh -v` also installs Vundle (`~/.vim/bundle/Vundle.vim`) as a side effect — this is a known inconsistency. Ubuntu/Synology bootstraps install only vim-plug.

```sh
vim +PlugInstall +qall
```

## Tmux

- Prefix + `I` installs TPM plugins (required after bootstrap).
- Prefix + `r` reloads `~/.tmux.conf`.
- Continuum auto-saves every 60s; auto-restores on boot (fullscreen).
- Plugins: sysstat, battery, continuum, resurrect, yank.

## Homebrew

`Brewfile` is the source of truth for packages, casks, and Mac App Store apps. `brew.sh` runs:
```sh
brew bundle --verbose --file=/usr/local/dotfiles/Brewfile
mas upgrade
```

## Git config

Default branch: `main`. Commit template at `~/.gitmessage`. GPG signing off. Key aliases in `the_dot_files/.gitconfig`:

| Alias | Expansion |
|-------|-----------|
| `git l` | `log --pretty=oneline -n 20 --graph --abbrev-commit` |
| `git ca` | `add -A && commit -av` |
| `git go` | Checkout existing or create new branch |
| `git hist` | Colored one-line graph with dates |

URL shorthands: `gh:` → `git@github.com:`, `gst:` → `git@gist.github.com:`.

## Mise

Runtime version manager. Config: `the_dot_files/.config/mise/config.toml`. Bootstrap migrates from asdf:
```sh
rm -rf ~/.asdfrc ~/.tool-versions ~/.asdf ~/.rvm
mise install
```

## Synology-specific

- zsh auto-starts via `~/.profile` (not `/etc/passwd` change) — safer, no lockout risk.
- tmux not included by default; install via Package Center then symlink manually.

## EditorConfig (`the_dot_files/.editorconfig`)

2-space indent, UTF-8, LF line endings, final newline, trim trailing whitespace.

## VCS exclusions

`.gitignore` excludes: `.claude`, `.claude.json`, `node_modules`, `package-lock.json`, `Brewfile.lock.json`, `.netrc`, `*license*`.

## Claude/OpenCode local config (gitignored)

`.claude/settings.local.json` pre-approves SSH and bootstrap script execution.

## No CI, no tests, no formatters

This is a personal config repo — no test suite, lint runner, or CI pipeline.
