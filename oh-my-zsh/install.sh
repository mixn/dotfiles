#!/bin/sh

###############################################################################
# oh-my-zsh                                                                   #
###############################################################################

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Make Zsh the default shell environment
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)