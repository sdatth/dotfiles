#  	 __  __       _         __ _ _
#	|  \/  | __ _| | _____ / _(_) | ___
#	| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#	| |  | | (_| |   <  __/  _| | |  __/
#	|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#
# source - https://github.com/sdatth/dotfiles

SHELL = /bin/bash

PKGS = gcc git fzf bat tmux neovim zsh vim glow eza fd starship btop stow zoxide
MPKGS = pinentry-mac gmake
FREEBSDPKGS = gcc git fzf bat glow eza fd-find starship btop stow neovim vim py39-ranger zsh tmux doas
DEVPKGS = go rust python@3.12
ARCHDEV = base-devel go rust python opendoas xclip alacritty

.ONESHELL:
help: ## Show available options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

config: nerdfonts symlink clean note ## Symlink config files

arch : arch-dep config ## Install on Arc

debian: deb-dep config ## Install on Debian based distros

ubuntu: ubuntu-dep config ## Install on Ubuntu based distros

freebsd: freebsd-dep nerdfonts symlink clean note ## Install on FreeBSD

rhel: rhel-dep config ## Install on rhel based distros

mac: config ## Install on MacOS


freebsd-dep: # Install doas on FreeBSD
	@echo
	echo "Installing BSD dependencies"
	sudo pkg update
	sudo pkg install $(FREEBSDPKGS)
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
	sudo usermod -aG wheel $(USER)
	echo

arch-dep: ##Install arch packages from standard repo
	@echo
	echo "Installing ARCH packages"
	sudo pacman -S --noconfirm $(PKGS) $(ARCHDEV)

deb-dep: # Install doas on Debian based distros
	@echo
	echo "Installing Debian Dependencies"
	sudo apt update
	sudo apt install build-essential opendoas
	echo

ubuntu-dep: # Install doas on Ubuntu based distros
	@echo
	echo "Installing Ubuntu Dependencies"
	sudo apt update
	sudo apt install build-essential doas
	echo

brew: ## Install brew package manager & brew packages
	@echo
	echo "Installing brew package manager"
	bash extra/brew-install.sh
	echo "Installing packages"
	source $(HOME)/.profile
	for item in $(PKGS); do \
		brew install $$item ; \
	done
	echo

nix: ## Install nix package manager & nix packages
	@echo
	echo "Installing nix package manager"
	sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
	source /etc/profile.d/nix.sh
	echo "Installing packages"
	for item in $(PKGS); do \
		nix-env -iA nixpkgs.$$item ; \
	done
	echo

dev: ## Optionally install development packages
	@echo
	brew install $(DEVPKGS)
	echo

delete: ## Delete old config files
	@echo
	read -p "Warning this will delete old configuration files if present [y|n]: " choice
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
		[ -d "$(HOME)/.local/share/fonts/firacode" ] && rm -rf "$(HOME)/.local/share/fonts/firacode"
		[ -d "$(HOME)/.local/share/fonts/hack" ] && rm -rf "$(HOME)/.local/share/fonts/hack"

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
	echo "Installing nerd fonts"
	source $(HOME)/.profile
	[ "$$(uname)" == "Darwin" ] && brew install --cask font-fira-code-nerd-font && exit 0
	mkdir -p $(HOME)/.local/share/fonts/firacode
	mkdir -p $(HOME)/.local/share/fonts/hack
	cp $(HOME)/dotfiles/fonts/firacode/* $(HOME)/.local/share/fonts/firacode/
	cp $(HOME)/dotfiles/fonts/hack/* $(HOME)/.local/share/fonts/hack/
	echo done!

symlink: delete
	@echo
	source $(HOME)/.profile
	[ -f "/etc/profile.d/nix.sh" ] && source /etc/profile.d/nix.sh
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
	echo "1. Append this line 'permit persist $(USER) as root' to /etc/doas.conf file."
	echo "2. For RHEL and FreeBSD based append 'permit persist :wheel' to this file '/usr/local/etc/doas.conf'"
	echo "3. Source profile 'source $(HOME)/.profile' to add brew bin for current shell or 'source /etc/profile.d/nix.sh' for nix package manager."
	echo "4. Open a new zsh shell with 'zsh' command to install few dependencies"
	echo "5. Exit and open a new zsh shell again to fix few stuff"
	echo "6. Open nvim then execute ':PlugInstall' in the respective editors to install all the plugins"
	echo "7. Update the '\sudo nano /etc/passwd' file, change the users shell to '/home/linuxbrew/.linuxbrew/bin/zsh' or '$(HOME)/.nix-profile/bin/zsh'"
	echo "8. Run this incase of FreeBSD 'chsh -s /usr/local/bin/zsh $(USER)' to change SHELL"
	echo "9. Incase of arch update the shell of $(USER) in '/etc/passwd' to $$(which zsh)"
	echo "10. For Mac change the font style in the terminal setting to use firacode"
	echo "11. (Optional) Reboot and ENjOy!"
	echo ""
	echo "Done installing the script!"
