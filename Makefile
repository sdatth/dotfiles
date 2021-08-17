#  	 __  __       _         __ _ _
#	|  \/  | __ _| | _____ / _(_) | ___
#	| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#	| |  | | (_| |   <  __/  _| | |  __/
#	|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#
# source - https://github.com/sdatth/dotfiles

SHELL = /bin/bash

PIP_PKGS = bpytop
CONF_PKGS = neovim vim vim-gtk3 curl git ranger zsh zsh-syntax-highlighting autojump
CONF_PKGS += zsh-autosuggestions tmux fd-find stow ncdu compton unzip build-essential
CONF_PKGS += lolcat figlet fortune cowsay python python3-testresources fish
ALACRITTY_PKGS = cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
MORE_PKGS = wormhole

.ONESHELL:
help: ## Show available options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: dep bindir pipinstall fzf bat glow exa fd nerdfonts starship utubedl symlink clean note ## Symlink config files

copy: dep bindir pipinstall fzf bat glow exa fd nerdfonts starship utubedl cpconf clean note ## Copy config files

dep: ## Install dependencies
	@echo
	echo "Installing Dependencies"
	sudo apt update
	sudo apt install $(CONF_PKGS) $(MORE_PKGS) || exit
	echo

more: ## Install additional packages
	@echo
	echo "Installing Additional Packages" | cowsay | lolcat
	sudo apt update
	sudo apt install $(MORE_PKGS)
	
pipinstall: # Install pip and its packages
	@echo
	export PATH=$$PATH:$$HOME/.local/bin
	echo "Installing pip and its packages" | cowsay | lolcat
	cd $(HOME)/temp
	curl "https://bootstrap.pypa.io/get-pip.py" -o "install-pip3.py"
	python3 install-pip3.py
	pip install --user --upgrade pip
	pip install --user $(PIP_PKGS)

bindir: ## Create ~/.local/bin dir
	- [ ! -d "$(HOME)/.local/bin" ] && mkdir -p $(HOME)/.local/bin
	- [ ! -d "$(HOME)/temp" ] && mkdir -p $(HOME)/temp
	echo "PATH=$$PATH:$$HOME/.local/bin" > $(HOME)/temp/pathfile
	sudo cp $(HOME)/temp/pathfile /etc/environment

delete: ## Delete old config files
	@echo
	read -p "Warning this will delete old files if present [y|n]: " choice
	if [ $$choice == "y" ]; then    
		echo "removing old files and dirs" | cowsay | lolcat
		[ -d "$(HOME)/.config/nvim" ] && rm -rf $(HOME)/.config/nvim
		[ -d "$(HOME)/.config/alacritty" ] && rm -rf $(HOME)/.config/alacritty
		[ -d "$(HOME)/.config/ranger" ] && rm -rf $(HOME)/.config/ranger
		[ -f "$(HOME)/.vimrc" ] && rm $(HOME)/.vimrc
		[ -f "$(HOME)/.zshrc" ] && rm $(HOME)/.zshrc
		[ -f "$(HOME)/.bashrc" ] && rm $(HOME)/.bashrc
		[ -f "$(HOME)/.Xresources" ] && rm $(HOME)/.Xresources
		[ -f "$(HOME)/.config/starship.toml" ] && rm $(HOME)/.config/starship.toml
		[ -d "$(HOME)/.local/share/nvim/site/autoload" ] && rm -rf $(HOME)/.local/share/nvim/site/autoload
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
	echo "installing plug for nvim" | cowsay | lolcat
	- [ ! -d "$(HOME)/.local/share/nvim/site/autoload" ] && mkdir -p "$(HOME)/.local/share/nvim/site/autoload"
	if [ -f "$(HOME)/.local/share/nvim/site/autoload/plug.vim" ]; then
		echo "Plug for neovim already installed"
	else
		echo "Installing Plug for neovim"
		sh -c 'curl -fLo $(HOME)/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	fi
	mkdir -p ~/.config/nvim/plugged
	echo done!

vimplug: ## Install plug for vim
	@echo
	echo "installing plug for vim" | cowsay | lolcat
	- [ ! -d "$(HOME)/.vim/autoload" ] && mkdir -p "$(HOME)/.vim/autoload"
	if [ -f "$(HOME)/.vim/autoload/plug.vim" ]; then
		echo "Plug for vim already installed"
	else
		curl -fLo $(HOME)/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
	mkdir -p ~/.vim/plugged
	echo done!

fzf: ## Install fzf
	@echo
	echo "installing fzf" | cowsay | lolcat
	git clone --depth 1 https://github.com/junegunn/fzf.git $(HOME)/.fzf
	$(HOME)/.fzf/install
	echo done!

bat: ## Install bat
	@echo 
	echo "installing bat" | cowsay | lolcat
	wget -P $(HOME)/temp/ https://github.com/sharkdp/bat/releases/download/v0.18.2/bat_0.18.2_amd64.deb
	sudo dpkg -i $(HOME)/temp/bat_0.18.2_amd64.deb
	echo done!

glow: ## Install glow
	@echo 
	echo "installing glow" | cowsay | lolcat
	wget -P $(HOME)/temp/ https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_amd64.deb
	sudo dpkg -i $(HOME)/temp/glow_1.4.1_linux_amd64.deb
	echo done!

exa: ## Install exa
	@echo
	echo "installing exa" | cowsay | lolcat
	cd $(HOME)/temp
	mkdir exa
	wget -P $(HOME)/temp/exa https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip
	cd exa
	unzip exa-linux-x86_64-v0.10.0.zip
	cp bin/exa $(HOME)/.local/bin/
	echo done!

fd: ## Install fd
	@echo
	echo "installing fd" | cowsay | lolcat
	#wget -P ~/temp/ https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb
	#sudo dpkg -i ~/temp/fd_8.2.1_amd64.deb
	ln -s $$(which fdfind) $(HOME)/.local/bin/fd
	echo done!

nerdfonts: ## Install nerd fonts
	@echo
	echo "nerd fonts" | cowsay | lolcat
	mkdir -p $(HOME)/.local/share/fonts/firacode
	mkdir -p $(HOME)/.local/share/fonts/hack
	cp $(HOME)/dotfiles/fonts/firacode/* $(HOME)/.local/share/fonts/firacode/ 
	cp $(HOME)/dotfiles/fonts/hack/* $(HOME)/.local/share/fonts/hack/ 
	echo done!

starship: ## Install starship prompt
	@echo 
	echo "installing starship" | cowsay | lolcat
	sh -c "$$(curl -fsSL https://starship.rs/install.sh)"
	echo done!

utubedl: ## Install youtube-dl
	@echo 
	echo "Installing youtube-dl" | cowsay | lolcat
	curl -L https://yt-dl.org/downloads/latest/youtube-dl -o $(HOME)/.local/bin/youtube-dl
	chmod a+rx $(HOME)/.local/bin/youtube-dl

symlink: delete vimplug nvimplug
	@echo 
	echo "Symlinking configuration files " | cowsay | lolcat
	cd $(HOME)/dotfiles/
	rm configurations/.vimrc
	rm configurations/.config/nvim/init.vim 
	mv extra/.wo-vimrc configurations/.vimrc
	mv extra/.wo-init.vim configurations/.config/nvim/init.vim
	stow -vt $(HOME) configurations/
	echo done!

cpconf: delete vimplug nvimplug 
	@echo
	echo "Copying files"
	cd $(HOME)/dotfiles/
	cp extra/.wo-vimrc $(HOME)/.vimrc
	cp extra/.wo-init.vim $(HOME)/.config/nvim/init.vim
	cp configurations/.config/starship.toml $(HOME)/.config/starship.toml
	cp -r configurations/.config/ranger $(HOME)/.config/
	cp configurations/.Xresources $(HOME)/
	cp configurations/.zshrc $(HOME)/
	cp configurations/.bashrc $(HOME)/
	cp -r configurations/.config/alacritty/ $(HOME)/.config/
	cp -r configurations/.config/fm6000 $(HOME)/.config/
	cp -r configurations/.config/fish $(HOME)/.config/

alacritty: ## Compile and install alacritty
	@echo
	echo "Installing alacritty" | cowsay | lolcat
	read -p "Do you want to compile and install alacritty from source [y|n]: " choice
	if [ $$choice == "y" ]; then 
		echo "installing alacritty" | cowsay | lolcat
		sudo apt install $(ALACRITTY_PKGS) 
		# install rust
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		source $(HOME)/.bashrc
		source $(HOME)/.cargo/env
		mkdir -p $(HOME)/temp/alacritty
		git clone https://github.com/alacritty/alacritty.git $(HOME)/temp/alacritty
		cd $(HOME)/temp/alacritty/
		rustup override set stable
		rustup update stable
		export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig
		cargo build --release
		sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
		sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
		sudo desktop-file-install extra/linux/Alacritty.desktop
		sudo update-desktop-database
	else
		echo "Not installing alacritty "
	fi

update:
	# fzf
	cd $(HOME)/.fzf && git pull && ./install
	
	# starship
	sh -c "$$(curl -fsSL https://starship.rs/install.sh)"

pull: ## Pull latest changes of git repo
	@echo
	cd $(HOME)/dotfiles
	git pull

clean: ## Clean up junk files after installation
	@echo
	echo "cleaning up!" | cowsay | lolcat
	rm -rf $(HOME)/temp/*
	echo done!
	
note:
	@echo
	echo "NOTE!" | cowsay | lolcat
	echo "1. Open vim n nvim then execute ':PlugInstall' in the respective editors to install all the plugins"
	echo "2. Uncomment the colorscheme line in the vimrc and nvimrc file to apply the theme"
	echo "3. Update the '/etc/passwd file, change the users shell to 'zsh' "
	echo "4: Once everything is done exec 'git restore .' in the '$(HOME)/dotfiles' dir "
	echo "4. Reboot(Optional) and ENjOy!"
	echo ""
	echo "Done installing the script!"

