function osx-update --description "Update Homebrew, vim plugins, tmux plugins, rvm, npm, OSX"
  # homebrew
  ~/temp/dotfiles/brew.sh

  # Oh my fish! update
  omf update

  # vim plugins
  vim +PluginClean +qall
  vim +PluginUpdate +qall

  # tmux plugin manager
  ~/.tmux/plugins/tpm/bin/clean_plugins
  ~/.tmux/plugins/tpm/bin/update_plugins all

  # rvm
  rvm get stable

  # node packages
  npm update -g --cache-min 60

  # OSX update
  mas upgrade
  sudo softwareupdate -i -a
  echo "To reboot: sudo shutdown -r now"
end
