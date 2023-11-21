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
	# Add the user to libvirt group
	sudo usermod -a -G libvirt $user

# Post installation activities
postinstall:
  echo "Starting Post Install just scripts"
  just --unstable gnome-extensions
  just --unstable toolbox-bluebox
  just --unstable nvchad
  just --unstable dotfiles
	just --unstable virtualisation
  echo "Finished Post Install"

