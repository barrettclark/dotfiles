function gccd --description "git clone and cd into directory" --wraps git
  # This is based on https://gist.github.com/noeldiaz/075ba3af7acfde333a687b1d71ff0dcf
  set repo $argv[1]
  set clonepath $argv[2]

  if test -z "$clonepath"
    set base (basename $repo)
    set clonepath (string replace -r "\.git" "" -- $base)
  end

  git clone $repo $clonepath
  cd $clonepath
end

