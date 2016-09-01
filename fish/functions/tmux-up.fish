function tmux-up --description "begin formatted tmux session"
  if count $argv > /dev/null
    set session_name $argv
    tmux has-session -t $session_name ^ /dev/null
    if test $status -eq 1
        tmux new-session -d -s $session_name
        tmux split-window -h -p 40
        tmux split-window -v -p 40
        # tmux send-keys -t 0 "vim" C-m
        tmux select-pane -t 0
    end
    tmux attach -t $session_name
  else
    echo " *** Try again with a session name"
  end
end

