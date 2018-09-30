# mixn’s Dotfiles

![mixn’s shell](https://i.imgur.com/RPk1Syt.png)

## Inspiration ❤️🌎

This repo is inspired and influenced by

- Mathias Bynens’ [dotfiles](https://github.com/mathiasbynens/dotfiles)
- Zach Holman’s [dotfiles](https://github.com/holman/dotfiles)
- Dries Vints’ [dotfiles](https://github.com/driesvints/dotfiles)
- Lars Kappert’s [dotfiles](https://github.com/webpro/dotfiles)
- Carlos Alexandro Becker’s [dotfiles](https://github.com/caarlos0/dotfiles)
- Paul Irish’s [dotfiles](https://github.com/paulirish/dotfiles)
- Ivan Santos’s [dotfiles](https://github.com/pragmaticivan/dotfiles)
- Alexander Myshov’s [dotfiles](https://github.com/myshov/dotfiles)
- Eduardo Rabelo’s [dotfiles](https://github.com/oieduardorabelo/dotfiles)
- Ryan Tomayko’s [dotfiles](https://github.com/rtomayko/dotfiles)

It’s not a fork of any, since I wanted to build from scratch and really **only** include what I need, while improving my understanding of how things work along the way.

Other inspiring and quite helpful articles, repos, tools, etc.:

- [Dotfiles Are Meant to Be Forked](https://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/)
- [Getting Started With Dotfiles (Lars Kappert)](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789)
- [Getting Started with Dotfiles (Dries Vints)](http://sourabhbajaj.com/mac-setup/)
- [Shell Startup Scripts](https://blog.flowblok.id.au/2013-02/shell-startup-scripts.html)
- [macOS Setup Guide](http://sourabhbajaj.com/mac-setup/)
- [Github does Dotfiles](https://dotfiles.github.io/)
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
- [Awesome Shell](https://github.com/alebcay/awesome-shell)
- [Awesome UNIX®](https://github.com/sirredbeard/Awesome-UNIX)

A big **thank you** to the dotfiles community and all aforementioned people — you all rock! 👨‍🎤

## Install

#### ⚠️ Disclaimer ⚠️

These are **my** dotfiles, so please feel free to take anything you want but do so **at your own risk**. 🙂 You should first fork this repository, review the code, and remove the things you don’t want or need. Don’t blindly use stuff unless you know what that entails.

Also — and this is just my personal opinion — I can **highly** recommend setting up your own `.files` (instead of forking an existing project) and moving along step by step. There is much to be learned and no better feeling than having full control over the things that are happening and being aware where everything is and what exactly it does. But that’s just me. 🙂

#### Clone with Git

On a fresh install of macOS, run:

```
sudo softwareupdate -i -a
xcode-select --install
```

Then clone the repo and run `scripts/install.sh`:

```
git clone https://github.com/mixn/dotfiles.git ~/.dotfiles
source ~/.dotfiles/scripts/install.sh
```

The missing `git/extra.sh` looks like this:

```
# Not in the repository, to prevent people from accidentally committing under my name
GIT_AUTHOR_NAME="mixn"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="sutanovac.milos@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

## Essentials 👩‍💻☕️

#### Core

- [bat](https://github.com/sharkdp/bat)
- [coreutils](https://en.wikipedia.org/wiki/GNU_Core_Utilities)
- [exa](https://github.com/ogham/exa)
- [fd](https://github.com/sharkdp/fd)
- [fzf](https://github.com/junegunn/fzf)
- [git](https://git-scm.com/)
  - [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
  - [git-extras](https://github.com/tj/git-extras)
  - [git-open](https://github.com/paulirish/git-open)
  - [git-recent](https://github.com/paulirish/git-recent)
  - [gitmoji-cli](https://github.com/carloscuesta/gitmoji-cli)
  - [tig](https://jonas.github.io/tig/)
  - [zsh git](https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh)
- [gtop](https://github.com/aksakalli/gtop)
- [Homebrew Cask](https://caskroom.github.io/)
- [Homebrew](https://brew.sh/)
- [peco](https://peco.github.io/)
- [qfc](https://github.com/pindexis/qfc)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [spot](https://github.com/rauchg/spot)
- [tokei](https://github.com/Aaronepower/tokei)
- [tree](http://mama.indstate.edu/users/ice/tree/)
- [wget](https://www.gnu.org/software/wget/)
- [z](https://github.com/rupa/z)

#### Shell

- [Ayu](https://github.com/ayu-theme)
- [Hyper](https://hyper.is/), [Hyper Plugins](./hyper/.hyper.js)
- [Pure](https://github.com/sindresorhus/pure)
- [tmux](https://github.com/tmux/tmux)
- [Zsh](https://www.zsh.org/)
  - [Antigen](https://github.com/zsh-users/antigen)
  - [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
  - [zsh-users stuff](https://github.com/zsh-users) and [more](./antigen/init.zsh)

#### JS

- [node](https://nodejs.org/en/)
- [nodemon](https://github.com/remy/nodemon)
- [np](https://github.com/sindresorhus/np)
- [npm](https://github.com/npm/cli), [yarn](https://yarnpkg.com/lang/en/)
- [nvm](https://github.com/creationix/nvm), [n](https://github.com/tj/n)
- [underscore-cli](https://github.com/ddopson/underscore-cli)

#### Helpers

- [carbon-now-cli](https://github.com/mixn/carbon-now-cli)
- [fast-cli](https://github.com/sindresorhus/fast-cli)
- [fkill-cli](https://github.com/sindresorhus/fkill-cli)
- [googler](https://github.com/jarun/googler)
- [grip](https://github.com/joeyespo/grip)
- [hstr](https://github.com/dvorka/hstr)
- [http-server](https://github.com/indexzero/http-server)
- [httpie](https://httpie.org/)
- [hyperfine](https://github.com/sharkdp/hyperfine)
- [is-up-cli](https://github.com/sindresorhus/is-up-cli)
- [PathPicker](https://github.com/facebook/PathPicker)
- [thefuck](https://github.com/nvbn/thefuck)
- [tldr](https://github.com/tldr-pages/tldr)
- [wifi-password](https://github.com/rauchg/wifi-password)
- [wttr](http://wttr.in/)
- [xsv](https://github.com/BurntSushi/xsv)

#### Graphics

- [ffmpeg](https://www.ffmpeg.org/)
- [imagemagick](https://www.imagemagick.org/script/index.php)
- [svgo](https://github.com/svg/svgo)

#### macOS

- [dark-mode-cli](https://github.com/sindresorhus/dark-mode-cli)
- [dockutil](https://github.com/kcrawford/dockutil)
- [file-type-cli](https://github.com/sindresorhus/file-type-cli)
- [macOS apps](./Brewfile)
- [mas](https://github.com/mas-cli/mas)
- [osx-wifi-cli](https://github.com/danyshaanan/osx-wifi-cli)
- [Quick Look Plugins](https://github.com/sindresorhus/quick-look-plugins)
- [trash-cli](https://github.com/sindresorhus/trash-cli)
- [wallpaper-cli](https://github.com/sindresorhus/wallpaper-cli)

## Author 🙂👋

| [![twitter/mixn](https://s.gravatar.com/avatar/25f6ced5bed9c19f2174e68798fb8f66?s=80)](http://twitter.com/mixn "Follow @mixn on Twitter") |
|---|
| [Miloš Sutanovac](https://mixn.io/) |
