set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Interactive/login shells {{{

set fish_plugins brew rvm
# rvm default

if status --is-login
  source /Users/43502/.config/fish/env.fish
  source /usr/local/opt/asdf/asdf.fish
end

# Load TCS file, if applicable/available
if test -e /Users/43502/.config/fish/tcs.env
  source /Users/43502/.config/fish/tcs.env
end

# }}}

abbr -a be bundle exec
abbr -a beg bundle exec rails g
abbr -a ber bundle exec rake
abbr -a dcb docker-compose up --build --remove-orphans
abbr -a dcd docker-compose down --remove-orphans
abbr -a gb git branch
abbr -a gbc 'git branch | grep -v master | xargs git branch -d'
abbr -a gc git commit
abbr -a gcm git checkout master
abbr -a gd 'git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'
abbr -a gf git fetch
abbr -a gpom git push origin master
abbr -a gs git status
abbr -a todo 'todo.sh -d ~/Dropbox/todo/todo.cfg'

alias md5sum gmd5sum
alias less 'less -r'
