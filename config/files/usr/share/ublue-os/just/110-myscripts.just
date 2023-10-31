
# Install recommended GNOME extensions
gnome-extensions:
  echo "Installing prefered Gnome Extensions"
  pip install --upgrade gnome-extensions-cli
  gext install appindicatorsupport@rgcjonas.gmail.com
  gext install openweather-extension@jenslody.de

# Install bluebox toolbox: ghcr.io/pliveyns/bluebox
toolbox-bluebox:
  # should not run if the toolbox already exists
  toolbox list --container | grep bluebox >& /dev/null
  if [ $? -eq 0 ]; then
    echo "The toolbx bluebox already exists and will not be installed"
  else
    echo "Installing bluebox toolbx"
    toolbox create -y -i ghcr.io/pliveyns/bluebox -c bluebox
  fi

# Install nvchad
nvchad:
	# First check if nvim folder is not yet created
  if [ -d "~/.config/nvim/" ]; then
    echo "Directory ~/.config/nvim/ already exists."
    echo "NvChad will not be installed"
  else
    echo "Installing NvChad for nvim"
    toolbox run --container bluebox git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
  fi

# Install dotfiles with chezmoi from gitlab
dotfiles:
  echo "Pulling dotfiles from gitlab"
  toolbox run --container bluebox chezmoi init --apply git@gitlab.com:pliveyns/dotfiles.git

# Post installation activities
postinstall:
  echo "Starting Post Install just scripts"
  just --unstable gnome-extensions
  just --unstable toolbox-bluebox
  just --unstable nvchad
  just --unstable dotfiles
  echo "Finished Post Install"

