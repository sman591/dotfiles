#!/bin/bash

echo "Installing oh my zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing development utilities..."
brew install rbenv ruby-build rbenv-default-gems bash-completion
brew install nodenv
brew install redis
brew install postgresql
brew install yarn
brew install tldr

echo "Installing user utilities..."
brew install cask
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv qlimagesize webpquicklook suspicious-package
