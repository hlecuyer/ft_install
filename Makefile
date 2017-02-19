
APT=sudo apt-get -y
WGET=wget -c
DIR=~/.ft_install
CODENAME=`lsb_release --codename --short`

all: git zshrc chrome emacs i3 docker spotify phpstorm php7 config slack postman upgrade

noui: git zshrc emacs docker php7 config upgrade

shippeo: all
		cat $(DIR)/i3/default.config $(DIR)/i3/shippeo.config > ~/ft_install/i3/config
		rm -rf ~/.config/i3/config
		ln -s $(DIR)/i3/config ~/.config/i3/config

home: all
		cat $(DIR)/i3/default.config $(DIR)/i3/home.config > ~/ft_install/i3/config
		rm -rf ~/.config/i3/config
		ln -s $(DIR)/i3/config ~/.config/i3/config

upgrade:
		$(APT) update
		$(APT) upgrade

git:
		$(APT) update
		$(APT) install git xclip htop
		ssh-keygen -t rsa -b 4096 -C "martin.leroy6@gmail.com"
		cat ~/.ssh/id_rsa.pub | xclip -selection c
		@echo ''
		@echo 'Your SSH Key is in your clipboard (Ctrl+v).'
		@echo 'Go on https://github.com/settings/ssh'
		@echo 'When you have finished "Press Enter" on this terminal'
		@read 'Waiting'
		git clone git@github.com:johnduro/ft_install.git $(DIR)

phpstorm:
		$(APT) install openjdk-8-jre
		$(WGET) --no-check-certificate https://download.jetbrains.com/webide/PhpStorm-2016.3.2.tar.gz
		tar xfz PhpStorm-*.tar.gz
		rm -f PhpStorm-*.tar.gz
		mv PhpStorm-* PhpStorm

zshrc:
		$(APT) install zsh
		git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
		cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
		chsh -s /bin/zsh

emacs:
		$(APT) install emacs
		git clone git@github.com:johnduro/emacs_config.git ~/.ft_emacs_config
		mkdir -p .emacs.d
		ln -s ~/.ft_emacs_config/dot_emacs.el ~/.emacs.d/init.el
		ln -s ~/.ft_emacs_config/lisp ~/.emacs.d/lisp

config:
		rm -rf ~/.zshrc ~/.config/i3 ~/.gitconfig
		ln -s $(which alsamixer) ~/bin/sound
		ln -s $(which xrandr) ~/bin/screen
		ln -s ~/PhpStorm/bin/phpstorm.sh ~/bin/phpstorm
		ln -s ~/Postman/Postman ~/bin/postman
		ln -s $(DIR)/.zshrc ~/.zshrc
		ln -s $(DIR)/i3/default.config ~/.config/i3/config
		ln -s $(DIR)/.gitconfig ~/.gitconfig

i3:
		sudo su -c "echo 'deb http://debian.sur5r.net/i3/ $(CODENAME) universe' >> /etc/apt/sources.list"
		$(APT) update
		$(APT) --allow-unauthenticated install sur5r-keyring
		$(APT) update
		$(APT) install i3 xautolock
		mkdir -p ~/.config/i3


docker:
		$(APT) update
		$(APT) install wget curl
		$(WGET) -qO- https://get.docker.com/ | sh
		sudo usermod -aG docker johnduro
		sudo su -c "curl -L https://github.com/docker/compose/releases/download/1.9.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
		sudo chmod +x /usr/local/bin/docker-compose

spotify:
		sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
		echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
		$(APT) update
		$(APT) install spotify-client

php7:
		$(APT) install python-software-properties
		sudo add-apt-repository -y ppa:ondrej/php
		$(APT) update
		$(APT) install php7.0 php7.0-mbstring php7.0-intl php-xml php-curl

chrome:
		$(WGET) https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
		sudo dpkg -i --force-all google-chrome-stable_current_amd64.deb
		$(APT) -f install
		rm -f google-chrome-stable_current_amd64.deb

slack:
		$(WGET) https://downloads.slack-edge.com/linux_releases/slack-desktop-2.1.2-amd64.deb
		sudo dpkg -i slack-desktop-2.1.2-amd64.deb
		rm -f slack-desktop-2.1.2-amd64.deb

postman:
		$(WGET) https://dl.pstmn.io/download/latest/linux64
		mv linux64 Postman-linux-x64.tar.gz
		tar -xzvf Postman-linux-x64.tar.gz
		rm -f Postman-linux-x64.tar.gz
