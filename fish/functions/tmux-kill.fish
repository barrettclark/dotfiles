function tmux-kill --description "Kill a tmux session by name"
  tmux kill-session -t $argv
end

