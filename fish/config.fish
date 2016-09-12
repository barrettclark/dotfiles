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
end

# }}}

abbr -a gs git status
abbr -a gc git commit
abbr -a gpom git push origin master
abbr -a be bundle exec
abbr -a ber bundle exec rake
abbr -a gd 'git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'
