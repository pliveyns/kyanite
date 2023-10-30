# vim: set ft=make :

# Install recommended GNOME extensions
gnome-extensions:
  pip install --upgrade gnome-extensions-cli
  gext install appindicatorsupport@rgcjonas.gmail.com
  gext install openweather-extension@jenslody.de

# Install bluebox toolbox: ghcr.io/pliveyns/bluebox
toolbox-bluebox:
  toolbox create -i ghcr.io/pliveyns/bluebox -c bluebox

# Install nvchad
nvchad:
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

# Install dotfiles with chezmoi from gitlab
dotfiles:
  toolbox run --container bluebox chezmoi init --apply git@gitlab.com:pliveyns/dotfiles.git

# Post installation activities
postinstall:

