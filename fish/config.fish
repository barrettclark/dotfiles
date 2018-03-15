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
  source ~/.config/fish/env.fish

  # Load TCS file, if applicable/available
  if test -e ~/.config/fish/tcs.env
    source ~/.config/fish/tcs.env
  end
end

# }}}

abbr -a gs git status
abbr -a gc git commit
abbr -a gpom git push origin master
abbr -a gcm git checkout master
abbr -a be bundle exec
abbr -a ber bundle exec rake
abbr -a beg bundle exec rails g
abbr -a gd 'git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'
abbr -a dcd docker-compose down
abbr -a dcb docker-compose up --build

alias md5sum gmd5sum

# Base16 Shell
if status --is-interactive
    eval sh $HOME/.config/base16-shell/scripts/base16-tomorrow-night.sh
end
