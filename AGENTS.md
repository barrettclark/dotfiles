# AGENTS.md — barrettclark/dotfiles

Personal dotfiles for Barrett Clark (barrett.clark@hashicorp.com). Shell, vim, tmux, macOS defaults, Homebrew packages, utility scripts.

## Repo anatomy

| Path | Purpose |
|------|---------|
| `zsh/.zshrc` | Zsh config — **symlinked** to `~/.zshrc` |
| `nvim/` | Neovim config (Lua, lazy.nvim) — **symlinked** to `~/.config/nvim` |
| `the_dot_files/.vimrc` | Vim config for servers (Ubuntu/Synology) — **symlinked** to `~/.vimrc` |
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
| `bootstrap.sh -s` | Symlinks only (`.zshrc`, `.vimrc`, `.tmux.conf`, `~/.config/nvim`) |
| `bootstrap.sh -d` | Rsync dotfiles only |
| `bootstrap.sh -v` | Neovim on Mac: symlink `nvim/` → `~/.config/nvim` + headless `Lazy! sync`; `.vimrc` stays rsynced for Ubuntu/Synology |
| `bootstrap_macos.sh` | macOS defaults + computer name (takes name arg, wine varieties) |
| `bootstrap_ubuntu_server.sh` | Headless Ubuntu 24 (zsh, vim, tmux, mise, starship) |
| `bootstrap_synology.sh` | Synology DSM (zsh, vim via .profile — no /etc/passwd changes) |

Flags for `bootstrap.sh`: `-a` (all), `-b` (bash), `-d` (dotfiles), `-h` (Homebrew), `-m` (mise), `-o` (OSX defaults), `-l` (linux), `-s` (symlinks), `-t` (tmux), `-v` (vim), `-z` (zsh).

## Submodules

```sh
git submodule update --init --recursive
```

- `zsh/myth-prompt-themes/` — barrettclark/myth-prompt-themes (Starship prompt theme)

(The old `.tmux` submodule was removed 2026-07 — tmux config lives entirely in
`the_dot_files/.tmux.conf`; `~/.tmux/` is just local tpack plugin/resurrect data.)

## Shell quirks

- **zsh-abbr** is Homebrew-only (`olets/tap/zsh-abbr`). Abbreviations won't expand on Linux or Synology.
- Uses **fast-syntax-highlighting** (not `zsh-syntax-highlighting`), **zsh-autosuggestions** (not `zsh-autocomplete`).
- Bash aliases sourced cross-shell from `bash_dot_files/.bash_aliases`.
- Starship prompt config lives in the `myth-prompt-themes` submodule.
- Terraform abbreviations via zsh-abbr: `tfi`, `tfp`, `tfa`, `tfv`, `tfw`, `tfo`, `tfs`, `tfsh`, `tfd`.
- `git-master-or-main` zsh function (`zsh/functions/git-master-or-main`) auto-detects default branch name.
- Computer names follow wine varieties (e.g. `bootstrap_macos.sh pinot-noir`).

## Neovim (Mac) / Vim (servers)

Mac uses Neovim: `nvim/` (Lua, lazy.nvim) is symlinked to `~/.config/nvim`;
`bootstrap.sh -v` runs a headless `Lazy! sync`. `vim`/`vimdiff` are aliased to
`nvim`/`nvim -d` and `EDITOR=nvim`, guarded on `command -v nvim` (`zsh/.zshrc:126-133`).
`lazy-lock.json` pins plugin versions — commit it when updating plugins.

Ubuntu/Synology keep plain vim with `the_dot_files/.vimrc` (vim-plug). The old
Vundle side effect in `bootstrap.sh -v` is gone.

```sh
vim +PlugInstall +qall
```

LSP servers install via mason (`:Mason`): gopls, terraform-ls, pyright, ruff,
ts_ls, eslint, ruby-lsp, jsonls. Treesitter uses `branch = "main"` (master is
archived and breaks on nvim 0.12+); parser builds need `tree-sitter-cli`
(Brewfile) and land in `~/.local/share/nvim/site/parser/`. Formatting via
conform.nvim — Go/Terraform on save,
everything else via `\F`; sqlformat is a custom formatter (`-r -k upper`).

AI plugins: coder/claudecode.nvim (`\a*` keymaps, connect with `/ide` from the
claude CLI) and NickvanDyke/opencode.nvim (`\ot` toggle, `\oa` ask with @this
context, `\op` prompt library).

## Terminal

Ghostty (cask) with config at `the_dot_files/.config/ghostty/config` (rsynced).
Theme is chalkboard with Hack Nerd Font Mono (Seoulbones Dark kept
commented as the previous choice — ghostty doesn't ship a Seoul256 theme).
Terminal.app kept as fallback.

## Tmux

- Plugin manager: **tpack** (`tmuxpack/tpack`) — installed via Homebrew (`tmuxpack/tpack/tpack`). Drop-in TPM replacement with a TUI.
- Prefix + `I` installs plugins (required after bootstrap).
- Prefix + `T` opens the tpack TUI to browse/install/update/remove plugins.
- Prefix + `r` reloads `~/.tmux.conf`.
- Continuum auto-saves every 60s; auto-restores on boot (fullscreen).
- Plugins: sysstat, battery, continuum, resurrect, treemux, yank.
- `treemux` (`kiyoon/treemux`) opens a neovim-tree sidebar (Prefix + `Tab`). Uses `nvim-tree` client with `~/.tmux/plugins/treemux/configs/treemux_init.lua`. The customized init file is stored in `the_dot_files/.tmux/plugins/treemux/configs/treemux_init.lua` and deployed by `bootstrap.sh -t` to survive plugin reinstalls. Opening a file (`<CR>`, `l`) targets the spawning pane (`tabnew_main_pane`); `v`/`<C-v>`/`<C-x>` still split.
- `@continuum-boot on` with `ghostty,fullscreen`. The LaunchAgent (`Tmux.Start.plist`) is stored in `the_dot_files/Library/LaunchAgents/` and deployed by `bootstrap.sh -d`; `bootstrap.sh -t` also loads it via `launchctl`. The boot script is `bin/tmux-ghostty-start.sh` (deployed to `~/bin/`).

(The old `.tmux` submodule was removed 2026-07; `~/.tmux/plugins/tpm` is no longer cloned — tpack manages plugin storage.)

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
