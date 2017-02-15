
APT=sudo apt-get -y
WGET=wget -c

all:

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
		git clone git@github.com:roukmoute/dotfiles.git ~/.dotfiles

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

config:
		ln -s $(which alsamixer) ~/bin/sound
		ln -s $(which xrandr) ~/bin/screen
