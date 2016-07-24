# Load other dotfiles (aliases, etc)
for file in ~/.{bash_aliases,bash_prompt,bash_exports,bash_functions}; do
	[ -r "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Finder Dock Mail Safari iTunes iCal Address\ Book SystemUIServer" killall

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

if [ -f ~/.ssh/id_rsa ]; then
    ssh-add ~/.ssh/id_rsa
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# The next line updates PATH for the Google Cloud SDK.
if [ -e /opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]; then
  source '/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
  # The next line enables bash completion for gcloud.
  source '/opt/homebrew-cask/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'
fi

# Mesosphere
if [ -f ~/bin/dcos/bin/env-setup ]; then
  source ~/bin/dcos/bin/env-setup
fi

# cp sadserver_tweets.dat /usr/local/share/games/fortunes
fortune sadserver_tweets | cowsay
