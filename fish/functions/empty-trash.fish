function empty-trash --description "Empty trashes on all volumes and clear some Apple cache"
  sudo rm -rfv /Volumes/*/.Trashes
  sudo rm -rfv ~/.Trash
  sudo rm -rfv /private/var/log/asl/*.asl
end

