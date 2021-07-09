fortune | cowsay
set -gx EDITOR /usr/local/bin/vim
set -gx BUNDLER_EDITOR $EDITOR
set -gx TERM "screen-256color"

# Manpage settings {{{
set -gx MANPAGER "less -X"
# }}}

# Todo.sh settings {{{
set -gx TODOTXT_DEFAULT_ACTION ls
# }}}

set -gx COPYFILE_DISABLE true

# PATH {{{
append-to-path ~/bin
append-to-path /usr/local/dotfiles/bin
append-to-path ~/Library/Python/2.7/bin
prepend-to-path /usr/local/sbin
set -gx PG_CONFIG /Applications/Postgres.app/Contents/Versions/9.6/bin
append-to-path $PG_CONFIG
# }}}

set JDK jdk1.8.0_112.jdk
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/$JDK/Contents/Home

# Go {{{
set -gx GOPATH ~/go
append-to-path $GOPATH
append-to-path $GOPATH/bin
# }}}

# Set locale
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
