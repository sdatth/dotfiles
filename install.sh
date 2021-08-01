#!/bin/bash

export PATH=$PATH:$HOME/.local/bin 

# installing dependencies
sudo apt update
sudo apt install neovim vim vim-gtk3 curl git ranger zsh zsh-syntax-highlighting autojump \
     zsh-autosuggestions tmux bat fd-find stow ncdu compton unzip build-essential lolcat figlet fortune cowsay || echo && echo "ERROr!" && exit

# removing old files n dirs
read -p "Warning this will delete old files if present [y|n]: " choice
if [ $choice == "y" ]; then    
    echo "removing old files and dirs" | lolcat | cowsay
    [ -d "$HOME/.config/nvim" ] && rm -rf $HOME/.config/nvim
    [ -d "$HOME/.config/alacritty" ] && rm -rf $HOME/.config/alacritty
    [ -d "$HOME/.config/ranger" ] && rm -rf $HOME/.config/ranger
    [ -f "$HOME/.vimrc" ] && rm $HOME/.vimrc
    [ -f "$HOME/.zshrc" ] && rm $HOME/.zshrc
    [ -f "$HOME/.Xresources" ] && rm $HOME/.Xresources
    [ -f "$HOME/.config/starship.toml" ] && rm $HOME/.config/starship.toml
    [ -d "$HOME/.local/share/nvim/site/autoload" ] && rm -rf $HOME/.local/share/nvim/site/autoload
    [ -d "$HOME/.vim/autoload" ] && rm -rf "$HOME/.vim/autoload"
    echo done!

elif [ $choice == "n" ]; then
    echo "Sorry to let u go!"
    exit

else
    echo "Next time enter [y|n]"
    exit
fi

# nvim plug
echo ""
echo "installing plug for nvim" | lolcat | cowsay
[ ! -d "$HOME/.local/share/nvim/site/autoload" ] && mkdir -p "$HOME/.local/share/nvim/site/autoload"
if [ -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
    echo "Plug for neovim already installed"
else
    echo "Installing Plug for neovim"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi
echo done!

# vim plug
echo ""
echo "installing plug for vim" | lolcat | cowsay
[ ! -d "$HOME/.vim/autoload" ] && mkdir -p "$HOME/.vim/autoload"
if [ -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo "Plug for vim already installed"
else
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
echo done!

# fzf
echo ""
echo "installing fzf" | lolcat | cowsay
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
echo done!

# bat
echo ""
echo "installing bat" | lolcat | cowsay
wget -P ~/Downloads/ https://github.com/sharkdp/bat/releases/download/v0.18.2/bat_0.18.2_amd64.deb
sudo dpkg -i ~/Downlodas/bat_0.18.2_amd64.deb
echo done!

# glow
echo ""
echo "installing glow" | lolcat | cowsay
wget -P $HOME/Downloads/ https://github.com/charmbracelet/glow/releases/download/v1.4.1/glow_1.4.1_linux_386.deb
sudo dpkg -i $HOME/Downloads/glow_1.4.1_linux_amd64.deb
echo done!

# exa
echo ""
echo "installing exa" | lolcat | cowsay
cd ~/Downloads
mkdir exa
wget -P $HOME/Downloads/exa https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip
cd exa
unzip exa-linux-x86_64-v0.10.0.zip
cp bin/exa ~/.local/bin/
echo done!

# fd
echo ""
echo "installing fd" | lolcat | cowsay
wget -P ~/Downloads/ https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb
sudo dpkg -i ~/Downloads/fd_8.2.1_amd64.deb
echo done!

# nerd fonts
echo "nerd fonts" | lolcat | cowsay
cd ~/Downloads
mkdir fonts && cd fonts
mkdir -p ~/.local/share/fonts/hack
wget https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
unzip Hack-v3.003-ttf.zip
cd ttf && cp * ~/.local/share/fonts/hack/ 
echo done!

# starship
echo ""
echo "installing starship" | lolcat | cowsay
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
echo done!

# syncing configurations
read -p "Symlink files [y|n]? " choice
if [ $choice == "y" ]; then
    # symlink
    echo ""
    echo "symlink" | lolcat | cowsay
    cd $HOME/dotfiles/
    rm configurations/.vimrc
    mv configurations/.wo-vimrc configurations/.vimrc
    rm configurations/.config/nvim/init.vim 
    mv configurations/.config/nvim/wo-init.vim configurations/.config/nvim/init.vim
    stow configurations/
    git restore .
    echo done!

elif [ $choice == "n" ]; then
    echo "Copying files"
    cd $HOME/dotfiles/
    
    # copying vimrc
    mkdir -p ~/.vim/plugged
    cp configurations/.config/.wo-vimrc $HOME/.vimrc

    # copying nvimrc
    mkdir -p ~/.config/nvim/plugged
    cp configurations/.config/nvim/wo-init.vim $HOME/.config/nvim/init.vim

    # starship
    cp configurations/.config/starship.toml $HOME/.config/starship.toml

    # ranger
    cp -r configurations/.config/ranger $HOME/.config/

    # Xrsources
    cp configurations/.Xresources $HOME/.config/

    # zshrc
    cp configurations/.zshrc $HOME/.config/

    # alacritty
    cp -r configurations/.config/alacritty/ $HOME/.config/
fi

# alacritty    
read -p "Do you want to compile and install alacritty from source [y|n]: " choice
if [ $choice == "y" ]; then 
    echo "installing alacritty" | lolcat | cowsay
    sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
    # install rust
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    exec bash
    source $HOME/.cargo/env
    mkdir -p ~/Downloads/alacritty
    git clone https://github.com/alacritty/alacritty.git ~/Downloads/alacritty
    cd ~/Downloads/alacritty/
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

# cleaning files
echo "cleaning up!" | lolcat | cowsay
rm -rf ~/Downloads/*
echo done!

echo "NOTE!"
echo "Open vim n nvim then execute ':PlugInstall' in the respective editors to install all the plugins"
echo "Uncomment the colorscheme line in the vimrc and nvimrc file to apply the theme"

echo ""
echo "Done installing the script!"




