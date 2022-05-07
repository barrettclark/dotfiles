function tmux-up --description "begin formatted tmux session"
  if count $argv > /dev/null
    set session_name $argv
    tmux has-session -t $session_name
    if test $status -eq 0
      tmux attach -t $session_name
    else
      if test -e ~/.tmuxp/$session_name.yaml
        tmuxp load $session_name
      else
        tmuxp load -s $session_name default
      end
    end
  else
    echo " *** Try again with a session name"
  end
end
