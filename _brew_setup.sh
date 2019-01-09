#!/bin/bash

# Installs homebrew and some essential apps

# Install Homebrew (http://brew.sh)
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update Homebrew
brew update

# Install brews and casks
brew bundle
