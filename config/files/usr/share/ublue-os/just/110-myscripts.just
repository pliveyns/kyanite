# vim: set ft=make :

# Install recommended GNOME extensions
gnome-extensions:
  echo "Installing prefered Gnome Extensions"
  pip install --upgrade gnome-extensions-cli
  gext install appindicatorsupport@rgcjonas.gmail.com
  gext install openweather-extension@jenslody.de

# Install bluebox toolbox: ghcr.io/pliveyns/bluebox
toolbox-bluebox:
  #!/bin/sh
  # should not run if the toolbox already exists
  toolbox list --containers | grep bluebox >& /dev/null
  if [ $? -eq 0 ]
  then
    echo "The toolbx bluebox already exists and will not be installed"
  else
    echo "Installing bluebox toolbx"
    toolbox create -y -i ghcr.io/pliveyns/bluebox -c bluebox
  fi

# Install nvchad
nvchad:
  #!/bin/sh
  # First check if nvim folder is not already existing
  if [ -d ~/.config/nvim/ ]
  then
    echo "Directory ~/.config/nvim/ already exists."
    echo "NvChad will not be installed."
  else
    echo "Installing NvChad for nvim"
    toolbox run --container bluebox git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
  fi

# Install dotfiles with chezmoi from gitlab
dotfiles:
  #!/bin/sh
  # Check if dotfiles was already installed
  if [ -f ~/.config/.dotfiles ]
  then
    echo "file ~/.config/.dotfiles already exists."
    echo "dotfiles will not be installed."
  else
    echo "Pulling dotfiles from gitlab"
    toolbox run --container bluebox chezmoi init --apply git@gitlab.com:pliveyns/dotfiles.git
  fi

# Setup virtualisation for the user
virtualisation:
  #!/bin/sh
  # Add the user to libvirt & qemu group
  sudo usermod -a -G libvirt ${USER}
  sudo usermod -a -G qemu ${USER}

# Set firefox as default default browser
default-browser-firefox:
  #!/bin/sh
  xdg-settings set default-web-browser org.mozilla.firefox.desktop

# Install Balena Etcher AppImage
balena-etcher:
  #!/bin/sh
  echo "Install Balena Etcher AppImage"
  curl -L https://github.com/balena-io/etcher/releases/download/v1.18.11/balenaEtcher-1.18.11-x64.AppImage -o /home/${USER}/.local/bin/balena-etcher.AppImage
  chmod +x /home/${USER}/.local/bin/balena-etcher.AppImage

# Post installation activities
postinstall:
  echo "Starting Post Install just scripts"
  just --unstable gnome-extensions
  just --unstable toolbox-bluebox
  just --unstable nvchad
  just --unstable dotfiles
  just --unstable virtualisation
  just --unstable default-browser-firefox
  just --unstable balena-etcher
  echo "Finished Post Install"

