function osx-update --description "Update Homebrew, vim plugins, tmux plugins, rvm, npm, OSX"
  # homebrew
  /usr/local/dotfiles/brew.sh

  # Fisherman update
  fisher update

  # vim plugins
  vim +PlugClean! +qall
  vim +PlugUpdate +qall
  vim +PlugUpgrade +qall

  # tmux plugin manager
  ~/.tmux/plugins/tpm/bin/clean_plugins
  ~/.tmux/plugins/tpm/bin/install_plugins
  ~/.tmux/plugins/tpm/bin/update_plugins all

  # rvm
  rvm get stable

  # node packages
  npm update -g --cache-min 60

  # OSX update
  reattach-to-user-namespace mas upgrade
  sudo softwareupdate --all --install --force
  echo "To reboot: sudo shutdown -r now"
end
