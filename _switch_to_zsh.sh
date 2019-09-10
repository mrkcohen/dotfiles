#!/bin/bash

# Changes default prompt from bash-->zsh

function switch_to_zsh {
  if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
     # assume Zsh
     echo 'Using zsh already'
  elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
     # assume Bash
     echo 'Switching bash --> zsh'
     chsh -s /bin/zsh
     echo 'Open a new shell tab/window to get zsh'
  else
     # asume something else
     echo 'Not sure what shell this is, switching to zsh anyways'
     chsh -s /bin/zsh
     echo 'Open a new shell tab/window to get zsh'
  fi
}

switch_to_zsh
