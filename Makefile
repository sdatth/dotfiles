#  	 __  __       _         __ _ _
#	|  \/  | __ _| | _____ / _(_) | ___
#	| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#	| |  | | (_| |   <  __/  _| | |  __/
#	|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#
# source - https://github.com/sdatth/dotfiles

SHELL = /usr/bin/bash

PKGS = git fzf bat glow exa fd starship youtube-dl bpytop stow
PKGS += neovim vim ranger zsh autojump tmux ncdu unzip
PKGS += lolcat figlet fortune cowsay fish

.ONESHELL:
help: ## Show available options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: dep nix-pman nerdfonts symlink clean note ## Symlink config files

dep: ## Install dependencies
	@echo
	echo "Installing Dependencies"
	sudo apt update
	sudo apt install compton build-essential || exit
	echo

brew-pman: ## Install brew package manager
	@echo "Installing brew package manager "
	bash extra/brew-install.sh
	echo "Installing packages"
	source $(HOME)/.profile
	brew install $(PKGS)

nix-pman: ## Install nix package manager
	@echo
	echo "Installing packages"
	for package in $(PKGS); do \
   		nix-env -iA nixpkgs.$$package ; \
	done

nix: ## Install nix package manager on linux
	@echo
	sh <(curl -L https://nixos.org/nix/install) --daemon
	echo 

nix-mac: ## Install nix package manager on mac
	@echo
	sh <(curl -L https://nixos.org/nix/install)
	echo

nix-wsl: ## Install nix package manager on windows wsl2
	@echo
	sh <(curl -L https://nixos.org/nix/install) --no-daemon
	echo

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
	echo "installing plug for nvim" | cowsay | lolcat
	- [ ! -d "$(HOME)/.config/nvim/autoload" ] && mkdir -p "$(HOME)/.config/nvim/autoload"
	if [ -f "$(HOME)/.config/nvim/autoload/plug.vim" ]; then
		echo "Plug for neovim already installed"
	else
		echo "Installing Plug for neovim"
		sh -c 'curl -fLo $(HOME)/.config/nvim/autoload/plug.vim --create-dirs \
       	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	fi
	mkdir -p ~/.config/nvim/plugged
	echo done!

nerdfonts: ## Install nerd fonts
	@echo
	echo "nerd fonts" | cowsay | lolcat
	mkdir -p $(HOME)/.local/share/fonts/firacode
	mkdir -p $(HOME)/.local/share/fonts/hack
	cp $(HOME)/dotfiles/fonts/firacode/* $(HOME)/.local/share/fonts/firacode/ 
	cp $(HOME)/dotfiles/fonts/hack/* $(HOME)/.local/share/fonts/hack/ 
	echo done!

symlink: delete
	@echo 
	echo "Symlinking configuration files " | cowsay | lolcat
	cd $(HOME)/dotfiles/
	stow -vt $(HOME) configurations/
	echo done!

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

