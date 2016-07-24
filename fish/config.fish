set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Interactive/login shells {{{

if status --is-login
  source ~/.config/fish/env.fish
end
