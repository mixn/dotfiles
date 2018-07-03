###############################################################################
# Git                                                                         #
###############################################################################

# The Regula ™
GIT_AUTHOR_NAME="mixn"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="sutanovac.milos@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

# Many, many other Git goodies I use are provided through oh-my-zsh
# Use diff-so-fancy by default for all git diff commands
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

# `git forget` for quickly discarding unstaged changes
# https://stackoverflow.com/a/1021384
git config --global alias.forget 'checkout .'

# Undo last commit, I keep using this, assuming it exists…
# Now it does
git config --global alias.undo 'reset HEAD~'