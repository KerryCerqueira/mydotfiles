#!/bin/bash    

# the directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# the temp directory used, within $DIR
# omit the -p parameter to create a temporal directory in the default location
WORK_DIR=`mktemp -d -p "$DIR"`

# check if tmp dir was created
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "Could not create temp dir"
  exit 1
fi

# deletes the temp directory
function cleanup {      
  rm -rf "$WORK_DIR"
  echo "Deleted temp working directory $WORK_DIR"
}

# register the cleanup function to be called on the EXIT signal
trap cleanup EXIT

# implementation of script starts here

#Install pulseaudio
#install_pulse && rm -rf "$HOME"/.config/pulse
#pulseaudio --start

#Install pacman installable packages
sudo pacman -Syu neovim python-pynvim alacritty ranger biber steam xournalpp firefox zsh rofi texlive-most zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps pkgfile

# install neovim-remote for vimtex compiler callbacks
git clone https://aur.archlinux.org/neovim-remote.git "$WORK_DIR"/neovim-remote
cd "$WORK_DIR"/neovim_remote && makepkg -si

# Dev icons for Ranger
git clone https://github.com/alexanderjeurissen/ranger_devicons.git "$HOME"/.config/ranger/plugins/ranger_devicons

# Miniconda
mkdir "$WORK_DIR"/miniconda && curl -o "$WORK_DIR"/miniconda/install.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
cd "$WORK_DIR"/miniconda; chmod u=rxw install.sh; ./install.sh -b

# Create conda environments
source "$HOME"/conda/bin/activate; conda init
conda config --add channels conda-forge
conda update -y conda; conda install -y jupyter ipykernel jupyterlab; conda create -y -n sage sage python=2.7; conda create -y -n anaconda anaconda

# R Studio and R jupyter kernel
git clone --depth=1 https://aur.archlinux.org/rstudio-desktop-bin.git "$WORK_DIR"/rstudio
cd "$WORK_DIR"/rstudio; makepkg -is --noconfirm
R -e "install.packages('IRkernel', lib='$HOME/R/templib', repos='https://cloud.r-project.org/'); library('IRkernel', lib.loc='$HOME/R/templib'); installspec(name='irkernel', displayname='R kernel')"

# Nerd Fonts
# Sourcecode pro font
# git clone --depth=1 https://aur.archlinux.org/nerd-fonts-source-code-pro.git "$WORK_DIR"/sourcecodepro/
# cd "$WORK_DIR"/sourcecodepro; makepkg -is
git https://aur.archlinux.org/nerd-fonts-complete.git "$WORK_DIR"/nerdfonts
cd "$WORK_DIR"/nerdfonts; makepkg -si

# oh-my-zsh and some plugins
cd "$WORK_DIR"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# deprecated: removed AUR oh-my-zsh in favor of git clone of the upstream repo
# git clone https://aur.archlinux.org/oh-my-zsh-git.git "$WORK_DIR"/oh-my-zsh
# cd "$WORK_DIR"/oh-my-zsh; makepkg -is
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME"/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME"/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions "$HOME"/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME"/plugins/zsh-syntax-highlighting

# install my dot files
touch "$HOME"/.gitignore && echo ".dotfiles" >> "$HOME"/.gitignore
git clone --bare https://github.com/KerryCerqueira/mydotfiles.git "$HOME/.dotfiles"

mkdir -p "$HOME"/.config-backup
cd $HOME
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME ls-tree -r --full-name --name-only master | xargs -I{} dirname {} | xargs -I{} mkdir --parents "$HOME"/.configs-backup/{}
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME ls-tree -r --full-name --name-only master | xargs -I{} mv "$HOME"/{} "$HOME"/.configs-backup/{}
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

# install nvim plugins
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall

exit 1
