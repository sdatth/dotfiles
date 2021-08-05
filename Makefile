#	__  __       _         __ _ _
#	|  \/  | __ _| | _____ / _(_) | ___
#	| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#	| |  | | (_| |   <  __/  _| | |  __/
#	|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#
# source - https://github.com/sdatth/dotfiles

SHELL = /bin/bash

PACKAGES = neovim vim vim-gtk3 curl git ranger zsh zsh-syntax-highlighting autojump
PACKAGES += zsh-autosuggestions tmux fd-find stow ncdu compton unzip build-essential
PACKAGES += lolcat figlet fortune cowsay
APACKAGES = cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

.ONESHELL:
all: dep bindir delete nvimplug vimplug fzf bat glow exa fd nerdfonts starship symlink clean note

dep: 
	@echo
	sudo apt update
	sudo apt install $(PACKAGES) 
	
bindir:
	[ ! -d "$(HOME)/.local/bin" ] && mkdir -p $(HOME)/.local/bin

delete:
	@echo
	read -p "Warning this will delete old files if present [y|n]: " choice
	if [ $$choice == "y" ]; then    
		echo "removing old files and dirs" | cowsay | lolcat
		[ -d "$(HOME)/.config/nvim" ] && rm -rf $(HOME)/.config/nvim
		[ -d "$(HOME)/.config/alacritty" ] && rm -rf $(HOME)/.config/alacritty
		[ -d "$(HOME)/.config/ranger" ] && rm -rf $(HOME)/.config/ranger
		[ -f "$(HOME)/.vimrc" ] && rm $(HOME)/.vimrc
		[ -f "$(HOME)/.zshrc" ] && rm $(HOME)/.zshrc
		[ -f "$(HOME)/.Xresources" ] && rm $(HOME)/.Xresources
		[ -f "$(HOME)/.config/starship.toml" ] && rm $(HOME)/.config/starship.toml
		[ -d "$(HOME)/.local/share/nvim/site/autoload" ] && rm -rf $(HOME)/.local/share/nvim/site/autoload
		[ -d "$(HOME)/.vim/autoload" ] && rm -rf "$(HOME)/.vim/autoload"
		echo done!
	elif [ $$choice == "n" ]; then
		echo "Sorry to let u go!"
		exit
	else
		echo "Next time enter [y|n]"
		exit
	fi
	echo done!

nvimplug:
	@echo 
	echo "installing plug for nvim" | cowsay | lolcat
	[ ! -d "$(HOME)/.local/share/nvim/site/autoload" ] && mkdir -p "$(HOME)/.local/share/nvim/site/autoload"
	if [ -f "$(HOME)/.local/share/nvim/site/autoload/plug.vim" ]; then
		echo "Plug for neovim already installed"
	else
		echo "Installing Plug for neovim"
		sh -c 'curl -fLo $(HOME)/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	fi
	echo done!

vimplug:
	@echo
	echo "installing plug for vim" | cowsay | lolcat
	[ ! -d "$(HOME)/.vim/autoload" ] && mkdir -p "$(HOME)/.vim/autoload"
	if [ -f "$(HOME)/.vim/autoload/plug.vim" ]; then
		echo "Plug for vim already installed"
	else
		curl -fLo $(HOME)/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
	echo done!

fzf:
	@echo
	echo "installing fzf" | cowsay | lolcat
	git clone --depth 1 https://github.com/junegunn/fzf.git $(HOME)/.fzf
	$(HOME)/.fzf/install
	echo done!

bat:
	@echo 
	echo "installing bat" | cowsay | lolcat
	wget -P $(HOME)/Downloads/ https://github.com/sharkdp/bat/releases/download/v0.18.2/bat_0.18.2_amd64.deb
	sudo dpkg -i $(HOME)/Downloads/bat_0.18.2_amd64.deb
	echo done!

glow:
	@echo 
	echo "installing glow" | cowsay | lolcat
	wget -P $(HOME)/Downloads/ https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_amd64.deb
	sudo dpkg -i $(HOME)/Downloads/glow_1.4.1_linux_amd64.deb
	echo done!

exa:
	@echo
	echo "installing exa" | cowsay | lolcat
	cd $(HOME)/Downloads
	mkdir exa
	wget -P $(HOME)/Downloads/exa https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip
	cd exa
	unzip exa-linux-x86_64-v0.10.0.zip
	cp bin/exa $(HOME)/.local/bin/
	echo done!

fd:
	@echo
	echo "installing fd" | cowsay | lolcat
	#wget -P ~/Downloads/ https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb
	#sudo dpkg -i ~/Downloads/fd_8.2.1_amd64.deb
	ln -s $$(which fdfind) $(HOME)/.local/bin/fd
	echo done!

nerdfonts:
	echo "nerd fonts" | cowsay | lolcat
	cd $(HOME)/Downloads
	mkdir fonts && cd fonts
	mkdir -p $(HOME)/.local/share/fonts/hack
	wget https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
	unzip Hack-v3.003-ttf.zip
	cd ttf && cp * $(HOME)/.local/share/fonts/hack/ 
	echo done!

starship:
	@echo 
	echo "installing starship" | cowsay | lolcat
	curl -fsSL https://starship.rs/install.sh > $(HOME)/Downloads/starship.sh
	chmod +x $(HOME)/Downloads/starship.sh
	sh -c $(HOME)/Downloads/starship.sh
	echo done!

symlink:
	@echo 
	echo "Symlinking configuration files " | cowsay | lolcat
	rm $(HOME)/.zshrc
	cd $(HOME)/dotfiles/
	rm configurations/.vimrc
	mv configurations/.wo-vimrc configurations/.vimrc
	rm configurations/.config/nvim/init.vim 
	mv configurations/.config/nvim/wo-init.vim configurations/.config/nvim/init.vim
	stow configurations/
	echo done!

cpconf:
	@echo
	echo "Copying files"
	cd $(HOME)/dotfiles/
	mkdir -p ~/.vim/plugged
	cp configurations/.wo-vimrc $(HOME)/.vimrc
	mkdir -p ~/.config/nvim/plugged
	cp configurations/.config/nvim/wo-init.vim $(HOME)/.config/nvim/init.vim
	cp configurations/.config/starship.toml $(HOME)/.config/starship.toml
	cp -r configurations/.config/ranger $(HOME)/.config/
	cp configurations/.Xresources $(HOME)/
	cp configurations/.zshrc $(HOME)/
	cp -r configurations/.config/alacritty/ $(HOME)/.config/

alacritty:
	@echo
	echo "Installing alacritty" | cowsay | lolcat
	read -p "Do you want to compile and install alacritty from source [y|n]: " choice
	if [ $$choice == "y" ]; then 
		echo "installing alacritty" | cowsay | lolcat
		sudo apt install $(APACKAGES) 
		# install rust
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		source $(HOME)/.bashrc
		source $(HOME)/.cargo/env
		mkdir -p $(HOME)/Downloads/alacritty
		git clone https://github.com/alacritty/alacritty.git $(HOME)/Downloads/alacritty
		cd $(HOME)/Downloads/alacritty/
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

clean:
	@echo
	echo "cleaning up!" | cowsay | lolcat
	rm -rf $HOME/Downloads/*
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

