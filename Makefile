
APT=sudo apt-get -y
WGET=wget -c

all:

upgrade:
		$(APT) update
		$(APT) upgrade

git:
		$(APT) update
		$(APT) install git htop
