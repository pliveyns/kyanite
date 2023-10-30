# vim: set ft=make :

# Install recommended GNOME extensions
gnome-extensions:
	pip install --upgrade gnome-extensions-cli
  gext install appindicatorsupport@rgcjonas.gmail.com
  gext install openweather-extension@jenslody.de

# Install bluebox toolbox: ghcr.io/pliveyns/bluebox
toolbox-bluebox:
  # should not run if the toolbox already exists
  toolbox create -y -i ghcr.io/pliveyns/bluebox -c bluebox

# Install nvchad
nvchad:
  toolbox run --container bluebox git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

# Install dotfiles with chezmoi from gitlab
dotfiles:
  toolbox run --container bluebox chezmoi init --apply git@gitlab.com:pliveyns/dotfiles.git

# Post installation activities
postinstall:
  just --unstable gnome-extensions
  just --unstable toolbox-bluebox
  just --unstable nvchad
  just --unstable dotfiles

