# New Artemis
# New Zeus

update: pull rebuild

rebuild:
  nixy rebuild

pull:
  git stash
  git pull
  git stash pop
