fortune sadserver_tweets | cowsay
set -gx EDITOR /usr/local/bin/vim
set -gx BUNDLER_EDITOR $EDITOR
set -gx TERM "screen-256color"

# Manpage settings {{{
set -gx MANPAGER "less -X"
# }}}

set -gx COPYFILE_DISABLE true

# PATH {{{
append-to-path ~/bin
prepend-to-path /usr/local/sbin
append-to-path /Applications/Postgres.app/Contents/Versions/9.6/bin
# }}}

set JDK jdk1.8.0_92.jdk
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/$JDK/Contents/Home

# Go {{{
set -gx GOPATH ~/go
append-to-path $GOPATH
# }}}

# Oracle {{{
append-to-path ~/instantclient_12_1
# }}}

# Set locale
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
