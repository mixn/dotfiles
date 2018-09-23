#!/bin/sh

###############################################################################
# oh-my-zsh                                                                   #
###############################################################################

# Install oh-my-zsh without user interaction
# Credit: https://goo.gl/uzeKuL
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o $DOTFILES/omz.sh
sed -i ''  '/echo/d' $DOTFILES/omz.sh
sed -i ''  '/env zsh/d' $DOTFILES/omz.sh
sh $DOTFILES/omz.sh
rm -rf $DOTFILES/omz.sh

# Make Zsh the default shell environment
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)