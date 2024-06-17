#!/bin/bash

# Title        brew.sh
# Description  Install/upgrade Homebrew packages and casks
# Author       Rushil Basappa <rushil.basappa@gmail.com>
#==============================================================================
print_banner() {
  echo -e "
██╗  ██╗ ██████╗ ███╗   ███╗███████╗██████╗ ██████╗ ███████╗██╗    ██╗
██║  ██║██╔═══██╗████╗ ████║██╔════╝██╔══██╗██╔══██╗██╔════╝██║    ██║
███████║██║   ██║██╔████╔██║█████╗  ██████╔╝██████╔╝█████╗  ██║ █╗ ██║
██╔══██║██║   ██║██║╚██╔╝██║██╔══╝  ██╔══██╗██╔══██╗██╔══╝  ██║███╗██║
██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗██████╔╝██║  ██║███████╗╚███╔███╔╝
╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚══╝╚══╝
"
}

install_homebrew() {
  echo -e "
=======================================================================
                         Installing Homebrew
=======================================================================
"
  which -s brew
  if [[ $? != 0 ]] ; then
    echo "==> Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    install_homebrew_taps
  else
    echo "==> Already installed."
  fi
}

install_homebrew_taps() {
  echo -e "Tapping to homebrew/cask-versions...\n"
  brew tap homebrew/cask-versions
}

keep_brew_up_to_date() {
  echo -e "
=======================================================================
                      Upgrading Outdated Plugin
======================================================================="
  brew outdated
  brew update
  brew upgrade
}

install_packages() {
  echo -e "
=======================================================================
                      Installing HomeBrew Packages
=======================================================================
"
  installed_packages=$(brew leaves)
  packages_filename='brew/packages.txt'

  for pkg in $(cat ${packages_filename}); do
    if ! (echo ${installed_packages} | grep -q ${pkg}); then
      echo -e "
===================
Installing Package: ${pkg}
===================
"
      brew install ${pkg}
    else
      echo "${pkg} - Done"
    fi
  done
}

install_casks() {
  echo -e "
=======================================================================
                      Installing HomeBrew Casks
======================================================================="

  installed_casks=$(brew list --cask)
  casks_filename='brew/casks.txt'

  for cask in $(cat ${casks_filename}); do
    if ! (echo ${installed_casks} | grep -q ${cask}); then
      echo -e "
===================
Installing Package: ${cask}
===================
"
      brew install --cask ${cask}
    else
      echo "${cask} - Done"
    fi
  done
}

list_all() {
    echo -e "
Installed Homebrew Packages:
----------------------------"
  brew leaves

  echo -e "
Installed Homebrew Casks:
-------------------------"
  brew list --cask | xargs -n1
}

verify_pre_install() {
  read -p "Do you want to install/upgrade Homebrew with additional packages and casks? (y/n): " input
  if [[ ${input} != "y" ]]; then
    echo -e "\n    Nothing has changed.\n"
    exit 0
  fi
}

main() {
  print_banner
  verify_pre_install
  install_homebrew
  keep_brew_up_to_date
  install_packages
  install_casks
  list_all

  # Assuming this script was executed via makefile
  # source brew/shell/oh-my-zsh-install.sh
  # oh_my_zsh_setup_install
}

main "$@"
