function git-master-or-main --description "Return whether the repo uses main or master"
  set main (git branch --list main)
  if test $main
    echo main
  else
    echo master
  end
end
