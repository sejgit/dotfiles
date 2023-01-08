# dotfiles
---
my current **dotfiles** for both `bash` and `zsh` 

the `zsh` version is more developed while the `bash` is more for fallback


## install:
**requires** `stow` and `antibody` if you are using the `zsh` version

**optional** `screenfetch`, `keychain` to be installed:


MacOS
````bash
brew install stow antibody screenfetch keychain

````

Linux - apt based
````bash
sudo apt install stow antibody screenfetch keychain

````

FreeBSD / Linux pkg based
````bash
sudo pkg install stow antibody screenfetch keychain

````

**if `antidote` is not in your packager then you need to clone the repository and put it into ~/.antidote
````bash
# first, run this from an interactive zsh terminal session:
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
````

#### implement `stow` links
- remove or store your current dotfiles
````bash
mkdir ~/olddots
mv .bash_logout .bash_path .bash_profile .bashrc .profile .inputrc .pythonstartup .aspell.conf olddots/
mv .zsh .zlogin .zprofile .zsh .zsh_plugins.txt .zsh_plugins.zsh .zshenv .zshrc olddots/
````

- now run stow to make your links
- if you see any errors it will mean that there are files in your home directory which interfere with `stow` and you need to remove/move them.
````bash
cd ~/dotfiles
stow -t ~/ -v shell
````

