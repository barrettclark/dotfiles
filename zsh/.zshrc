# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=(
#   "agnoster"
#   "amuse"
#   "robbyrussell"
# )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
# git clone https://github.com/zsh-git-prompt/zsh-git-prompt.git $ZSH_CUSTOM/plugins/zsh-git-prompt
# git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-fast-syntax-highlighting
# git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
# git clone https://github.com/olets/zsh-abbr --single-branch --branch main --depth 1 $ZSH_CUSTOM/plugins/zsh-abbr
plugins=(
  aliases
  asdf
  colorize
  command-not-found
  copypath
  dotenv
  git
  gitignore
  jsontools
  rake-fast
  safe-paste
  terraform
  tmux
  zsh-autocomplete
  zsh-autosuggestions
  fast-syntax-highlighting
  zsh-abbr
  zsh-syntax-highlighting
)

# Load HashiCorp settings if the file exists
if [ -f ~/.hashicorp.env ]; then
  ZSH_DOTENV_PROMPT=false
  ZSH_DOTENV_FILE=~/.hashicorp.env
fi

source "/usr/local/opt/asdf/libexec/asdf.sh"
source $ZSH/oh-my-zsh.sh
source "$ZSH_CUSTOM/plugins/zsh-git-prompt/zshrc.sh"

# User configuration

# command for zsh-completions
autoload -U compinit && compinit

ZSH_THEME_GIT_PROMPT_CACHE=1

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=$LANG

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# fortune | cowsay
export EDITOR="/usr/local/bin/vim"
export BUNDLER_EDITOR=$EDITOR
export TERM="screen-256color"
export LSCOLORS="gxfxbEaEBxxEhEhBaDaCaD"

# Manpage settings
export MANPAGER="less -X"

# Todo.sh settings
export TODOTXT_DEFAULT_ACTION="ls"

export GOPATH="~/go"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias md5sum="gmd5sum"
alias less="less -r"

# Functions
# add /usr/local/dotfiles/zsh/functions to fpath, and then lazy autoload
# every file in there as a function
# https://unix.stackexchange.com/a/526429
fpath=(/usr/local/dotfiles/zsh/functions $fpath);
autoload -U $fpath[1]/*(.:t)

# abbreviations
abbr be="bundle exec"
abbr beg="bundle exec rails g"
abbr ber="bundle exec rake"
abbr dcb="docker-compose up --build --remove-orphans"
abbr dcd="docker-compose down --remove-orphans"
abbr gb="git branch"
abbr gc="git commit"
abbr gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'
abbr gf="git fetch"
abbr gs="git status"
abbr tf="terraform"
abbr tfd="~/go/bin/terraform"
abbr todo="todo.sh -d ~/Dropbox/todo/todo.cfg"
abbr gbc="git branch | grep -v $(git-master-or-main) | xargs git branch -d"
abbr gcm="git checkout $(git-master-or-main)"
abbr gpom="git push origin $(git-master-or-main)"

export STARSHIP_CONFIG="/usr/local/dotfiles/zsh/myth-prompt-themes/colorful/pointed/starship/left_only/starship.toml"
eval "$(starship init zsh)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
