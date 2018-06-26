###############################################################################
# Git                                                                         #
###############################################################################

# Many, many other Git goodies I use are provided through oh-my-zsh
GIT_AUTHOR_NAME="mixn"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="sutmil@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

# Use diff-so-fancy by default for all git diff commands
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"