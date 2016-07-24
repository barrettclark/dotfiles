echo " *** Loading env ***"
set -gx EDITOR /usr/local/bin/vim
set -gx BUNDLER_EDITOR $EDITOR

# Manpage settings {{{
set -gx MANPAGER "less -X"
# }}}

set -gx COPYFILE_DISABLE true

# PATH {{{
append-to-path ~/bin
prepend-to-path /usr/local/sbin
# }}}


# Go {{{
set -gx GOPATH ~/go
append-to-path $GOPATH
# }}}

# Set locale
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
