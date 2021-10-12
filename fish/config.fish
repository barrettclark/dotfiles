set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Interactive/login shells {{{

set fish_plugins brew rvm
rvm default

if status --is-login
  source $HOME/.config/fish/env.fish
  source /usr/local/opt/asdf/asdf.fish
end

# Load HashiCorp file, if applicable/available
if test -e $HOME/.config/fish/hashicorp.env
  source $HOME/.config/fish/hashicorp.env
end

# }}}

abbr -a be bundle exec
abbr -a beg bundle exec rails g
abbr -a ber bundle exec rake
abbr -a dcb docker-compose up --build --remove-orphans
abbr -a dcd docker-compose down --remove-orphans
abbr -a gb git branch
abbr -a gbc 'git branch | grep -v (git-master-or-main) | xargs git branch -d'
abbr -a gc git commit
abbr -a gcm git checkout (git-master-or-main)
abbr -a gd 'git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'
abbr -a gf git fetch
abbr -a gpom git push origin (git-master-or-main)
abbr -a gs git status
abbr -a tf terraform
abbr -a todo 'todo.sh -d ~/Dropbox/todo/todo.cfg'

alias md5sum gmd5sum
alias less 'less -r'

status --is-interactive; and source (jenv init -|psub)
