#!/bin/bash

echo "Installing development utilities..."
brew install rbenv ruby-build rbenv-default-gems bash-completion
brew install nodenv
brew install redis
brew install postgresql

echo "Installing user utilities..."
brew install cask
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
