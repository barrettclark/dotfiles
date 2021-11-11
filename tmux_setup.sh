#!/bin/bash

# tmux CPU stats
git clone https://github.com/thewtex/tmux-mem-cpu-load.git
cd tmux-mem-cpu-load
cmake .
make
sudo make install
cd -
rm -rf tmux-mem-cpu-load

# tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "In tmux run prefix + I"

cat << EOF > ~/.tmuxp/dotfiles.yaml
session_name: dotfiles
windows:
  - layout: main-vertical
    focus: 'true'
    options:
      main-pane-width: 55%
      automatic-rename: 'off'
    shell_command_before:
      - cd /usr/local/dotfiles
    panes:
      - focus: true
      - blank
      - blank
EOF
