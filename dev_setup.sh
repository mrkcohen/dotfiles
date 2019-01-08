#!/bin/bash

# Run basic prompt setup
# Install all the dotfiles in this directory (symlink them into place)
# When a file already exists, copy it to an "old_dotfiles" directory first
# When a symlink already exists, replace it

function create_symlink {
  echo "Created symlink: $2 -> $1"
  ln -s $1 $2
}

function install_oh_my_zsh {
  if [ -d ${HOME}/.oh-my-zsh/ ]; then
    echo "Found ~/.oh-my-zsh"
  else
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi
}

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

function install_powerlevel9k {
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/bhilburn/powerlevel9k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel9k
  echo "Don't forget to update the font in iTerm to 'Hack Regular Nerd Font Complete'"
}

function run_brewfile {
  brew bundle
}

function make_symlinks {
  declare -a dotfile_whitelist=(
    .bash_profile\
    .bash_includes\
    .gitconfig\
    .gitignore\
    .zshrc\
  )

  backup_dir="${HOME}/old_dotfiles"

  cd `dirname $0`

  for f in ${dotfile_whitelist[@]}; do
    # In the repo I don't include the leading dot so they're not all hidden
    if [[ $f =~ ^\. ]]
    then
      repo_filename=${f:1}
    else
      repo_filename=${f}
    fi
    repo_file=$(pwd)/${repo_filename}

    # if whitelisted file isn't actually in repo, skip
    if [ ! -f ${repo_file} -a ! -d ${repo_file} ]
    then
      continue
    fi

    dotfile=${HOME}/.${repo_filename}

    # if file or dir exists, back it up then create symlink
    if [ -f ${dotfile} -o -d ${dotfile} ] && [ ! -h ${dotfile} ]
    then
      if [ ! -d ${backup_dir} ]
      then
        echo "WARN: made backup directory ${backup_dir}"
        mkdir ${backup_dir}
      fi
      echo "WARN: moving existing ${dotfile} to ${backup_dir}" 1>&2
      mv ${dotfile} ${backup_dir}
      create_symlink "${repo_file}" "${dotfile}"
      continue
    fi

    # if symlink exists and is different, warn then create new symlink
    if [ -h "${dotfile}" ]
    then
      current_target=`ls -l ${dotfile} | awk '{print $11}'`
      if [ "${current_target}" != "${repo_file}" ]
      then
        echo "WARN: removed symlink: ${dotfile} -> ${current_target}" 1>&2
        rm "${dotfile}"
        create_symlink "${repo_file}" "${dotfile}"
      else
        echo "file ${dotfile} already set correctly" 1>&2
      fi
      continue
    fi

    # doesn't exist yet, create symlink
    if [ ! -a "${dotfile}" ]
    then
      create_symlink "${repo_file}" "${dotfile}"
      continue
    fi
  done
}

# Main
run_brewfile
install_oh_my_zsh
switch_to_zsh
install_powerlevel9k
make_symlinks
