sudo apt update
sudo apt upgrade
sudo apt-key adv --keyserver hkp://keys.gnupg.net:80 --recv-keys A04A6C4681484CF1
sudo apt-key adv --keyserver hkp://keys.gnupg.net:80 --recv-keys 648ACFD622F3D138
sudo echo -e "deb http://deb.debian.org/debian buster-backports main\n" >> /etc/apt/sources.list
sudo apt update
sudo apt install -t buster-backports emacs-nox
cp mini_emacs ~/.emacs.d
emacs --version
sudo rm -rf /etc/emacs/site-start.d
sudo mkdir /etc/emacs/site-start.d
emacs
