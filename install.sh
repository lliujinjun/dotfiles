#!/usr/bin/env sh
set -x

# download fresh package databases from the server
sudo pacman --sync --refresh --noprogressbar >/dev/null
# upgrade installed packages
sudo pacman --sync --sysupgrade --noconfirm --noprogressbar >/dev/null
# install mandoc package
sudo pacman --sync --needed --noconfirm --noprogressbar mandoc &>/dev/null
# install emacs-nox package and dependencies
sudo pacman --sync --needed --noconfirm --noprogressbar emacs-nox &>/dev/null
# install fish package
sudo pacman --sync --needed --noconfirm --noprogressbar fish &>/dev/null
# install tmux package and dependencies
sudo pacman --sync --needed --noconfirm --noprogressbar tmux &>/dev/null
# install git package and dependencies
sudo pacman --sync --needed --noconfirm --noprogressbar git &>/dev/null
# install inetutils package
#sudo pacman --sync --needed --noconfirm --noprogressbar inetutils &>/dev/null
# install kitty-terminfo package
sudo pacman --sync --needed --noconfirm --noprogressbar kitty-terminfo &>/dev/null
# install podman package and dependencies
sudo pacman --sync --needed --noconfirm --noprogressbar podman &>/dev/null
# install fzf package
sudo pacman --sync --needed --noconfirm --noprogressbar fzf &>/dev/null

# run rootless podman
sudo touch /etc/subuid /etc/subgid
sudo usermod --add-subuids 10000-75535 --add-subgids 10000-75535 $USER

# initialize system dotfiles
git clone --bare https://github.com/lliujinjun/dotfiles.git ~/.dotfiles 2>/dev/null
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout --force
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config status.showUntrackedFiles no

# create an ssh key pair
ssh-keygen -q -b 521 -C "lliujinjun@163.com" -f $HOME/.ssh/id_ecdsa -N '' -t ecdsa

# start emacs daemon with systemd
systemctl enable --user --now emacs
