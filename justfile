# New Node
# New Core

update: pull rebuild

rebuild:
  nixy rebuild

pull:
  git stash
  git pull
  git stash pop
