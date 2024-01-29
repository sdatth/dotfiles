#  	 __  __       _         __ _ _
#	|  \/  | __ _| | _____ / _(_) | ___
#	| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#	| |  | | (_| |   <  __/  _| | |  __/
#	|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#
# source - https://github.com/sdatth/dotfiles

SHELL = /usr/bin/bash

PKGS = gcc git fzf bat glow eza fd starship btop stow
PKGS += neovim vim ranger zsh tmux ncdu unzip
PKGS += lolcat figlet screen

DEVPKGS = go rust python@3.12
ARCHDEV = go rust python opendoas

.ONESHELL:
help: ## Show available options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: brew nerdfonts symlink clean note ## Symlink config files

arch : arch-dep nerdfonts symlink clean note ## Install on Arc

debian: deb-dep install ## Install on Debian based distros

ubuntu: ubuntu-dep install ## Install on Ubuntu based distros

freebsd: freebsd-dep install ## Install on FreeBSD

rhel: rhel-dep install ## Install on rhel based distros

freebsd-dep: # Install doas on FreeBSD
	@echo
	echo "Installing BSD dependencies"
	sudo pkg update
	sudo pkg install doas
	echo

rhel-dep: # Install doas on RHEl based distros 
	@echo
	echo "Installing RPM Dependencies"
	sudo yum install -y epel-release gcc gcc-c++ make flex bison pam-devel byacc
	sudo yum groupinstall -y "Development Tools"
	[ -d "$(HOME)/temp" ] && cd $(HOME)/temp || mkdir $(HOME)/temp 
	cd $(HOME)/temp/
	git clone https://github.com/slicer69/doas.git
	cd doas
	make
	sudo make install
	sudo cp /etc/pam.d/sudo /etc/pam.d/doas
	echo

arch-dep: ##Install arch packages from standard repo
	@echo
	echo "Installing ARCH packages"
	sudo pacman -S --noconfirm $(PKGS)
	sudo pacman -S --noconfirm $(ARCHDEV)

deb-dep: # Install doas on Debian based distros
	@echo
	echo "Installing Debian Dependencies"
	sudo apt update
	sudo apt install opendoas
	echo

ubuntu-dep: # Install doas on Ubuntu based distros
	@echo
	echo "Installing Ubuntu Dependencies"
	sudo apt update
	sudo apt install doas
	echo		

brew: ## Install brew package manager
	@echo "Installing brew package manager "
	bash extra/brew-install.sh
	echo "Installing packages"
	source $(HOME)/.profile
	brew install $(PKGS)
	brew postinstall gcc
	echo

dev: ## Optionally install development packages
	@echo
	brew install $(DEVPKGS)
	echo	

delete: ## Delete old config files
	@echo
	read -p "Warning this will delete old files if present [y|n]: " choice
	if [ $$choice == "y" ]; then    
		echo "removing old files and dirs"
		[ -d "$(HOME)/.config/nvim" ] && rm -rf $(HOME)/.config/nvim
		[ -d "$(HOME)/.config/alacritty" ] && rm -rf $(HOME)/.config/alacritty
		[ -d "$(HOME)/.config/ranger" ] && rm -rf $(HOME)/.config/ranger
		[ -d "$(HOME)/.autoload" ] && rm -rf $(HOME)/.autoload
		[ -f "$(HOME)/.vimrc" ] && rm $(HOME)/.vimrc
		[ -f "$(HOME)/.zshrc" ] && rm $(HOME)/.zshrc
		[ -f "$(HOME)/.bashrc" ] && rm $(HOME)/.bashrc
		[ -f "$(HOME)/.Xresources" ] && rm $(HOME)/.Xresources
		[ -f "$(HOME)/.config/starship.toml" ] && rm $(HOME)/.config/starship.toml
		[ -d "$(HOME)/.config/nvim/autoload" ] && rm -rf $(HOME)/.config/nvim/
		[ -d "$(HOME)/.vim" ] && rm -rf "$(HOME)/.vim"
		[ -d "$(HOME)/.zsh_functions" ] && rm -rf "$(HOME)/.zsh_functions"
		[ -d "$(HOME)/.config/fish" ] && rm -rf "$(HOME)/.config/fish"
		echo done!
	elif [ $$choice == "n" ]; then
		echo "Sorry to let u go!"
		exit
	else
		echo "Next time enter [y|n]"
		exit
	fi
	echo done!

nvimplug: ## Install plug for neovim
	@echo 
	echo "installing plug for nvim"
	- [ ! -d "$(HOME)/.config/nvim/autoload" ] && mkdir -p "$(HOME)/.config/nvim/autoload"
	if [ -f "$(HOME)/.config/nvim/autoload/plug.vim" ]; then
		echo "Plug for neovim already installed. Please open nvim and type ':PlugUpgrade' to upgrade it"
	else
		echo "Installing Plug for neovim"
		sh -c 'curl -fLo $(HOME)/.config/nvim/autoload/plug.vim --create-dirs \
       	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	fi
	mkdir -p ~/.config/nvim/plugged
	echo done!

nerdfonts: ## Install nerd fonts
	@echo
	echo "nerd fonts"
	mkdir -p $(HOME)/.local/share/fonts/firacode
	mkdir -p $(HOME)/.local/share/fonts/hack
	cp $(HOME)/dotfiles/fonts/firacode/* $(HOME)/.local/share/fonts/firacode/ 
	cp $(HOME)/dotfiles/fonts/hack/* $(HOME)/.local/share/fonts/hack/ 
	echo done!

symlink: delete
	@echo
	source $(HOME)/.profile 
	echo "Symlinking configuration files"
	cd $(HOME)/dotfiles/
	stow -vt $(HOME) configurations/
	echo done!

pull: ## Pull latest changes of git repo
	@echo
	cd $(HOME)/dotfiles
	git pull

clean: ## Clean up junk files after installation
	@echo
	echo "cleaning up!"
	rm -rf $(HOME)/temp/*
	echo done!

note:
	@echo
	echo "NOTE!"
	echo "1. Append this line 'permit persist $(USER) as root' to /etc/doas.conf file. Visit 'https://github.com/slicer69/doas.git' incase for more details "
	echo "2. Source profile 'source $(HOME)/.profile' to add brew bin for current shell"
	echo "3. Open a new zsh shell with 'zsh' command to install few dependencies"
	echo "4. Exit and open a new zsh shell again to fix few stuff"
	echo "5. Open nvim then execute ':PlugInstall' in the respective editors to install all the plugins"
	echo "6. Update the '\sudo nano /etc/passwd file, change the users shell to '/home/linuxbrew/.linuxbrew/bin/zsh' "
	echo "7: (Optional) Reboot and ENjOy!"
	echo ""
	echo "Done installing the script!"

