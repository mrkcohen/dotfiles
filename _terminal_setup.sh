#!/bin/bash

# Setups up the zsh prompt w/ Powerlevel9k

function install_oh_my_zsh {
  if [ -d ${HOME}/.oh-my-zsh/ ]; then
    echo "Found ~/.oh-my-zsh"
  else
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi
}

function install_powerlevel9k {
  if [ -d ${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/ ] ; then
    echo "zsh syntax highlighting already installed"
  else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  fi

  if [ -d ${HOME}/.oh-my-zsh/custom/themes/powerlevel9k/ ] ; then
    echo "Powerlevel9k theme already installed"
  else
    git clone https://github.com/bhilburn/powerlevel9k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel9k
  fi
  echo "Don't forget to update the font in iTerm to 'Hack Regular Nerd Font Complete'"
}

install_oh_my_zsh
install_powerlevel9k
