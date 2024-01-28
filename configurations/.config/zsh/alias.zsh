## aliases
# navigation
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# nixos
alias nu="doas nixos-rebuild switch --flake '.#zeta'"
alias nl='doas nix-env --list-generations --profile /nix/var/nix/profiles/system'
alias ngc='nix-collect-garbage'
alias sngc='doas nix-collect-garbage'

# apt
alias ai="doas apt install"
alias au="doas apt update"
alias aU="doas apt upgrade"
alias ar="doas apt remove --purge"

# brew 
alias bu='brew update'
alias bU='brew upgrade'
alias bgc='brew cleanup && brew autoremove'
alias bl='brew leaves'
alias bi='brew install'
alias br='brew uninstall'
alias bcl='brew list --cask'
alias bci='brew install --cask'
alias bcr='brew uninstall --cask'

# pacman 
alias pi="doas pacman -S"
alias pu="doas pacman -Sy"
alias pU="doas pacman -Syu"
alias pr="doas pacman -Rs"

# snapper alias
alias src="doas snapper -c root create -d" 
alias shc="doas snapper -c home create -d" 
alias srd="doas snapper -c root delete"
alias shd="doas snapper -c home delete"
alias srl="doas snapper -c root list"
alias shl="doas snapper -c home list"
alias sru="doas snapper -c root undochange"
alias srh="doas snapper -c home undochange"
alias srr="doas snapper --ambit classic rollback"
alias grubmake="doas grub-mkconfig -o /boot/grub/grub.cfg"
alias grubinstall="doas grub-install --target=x86_64-efi --efi-directory=/efi --boot-directory=/boot --bootloader-id=GRUB"

# screem
alias ss="screen -S"
alias sr="screen -r"
alias sl="screen -ls"
alias sx="screen -X -S"

# brew 
alias bu='brew update'
alias bU='brew upgrade'
alias bgc='brew cleanup && brew autoremove'
alias bl='brew leaves'
alias bi='brew install'
alias br='brew uninstall'
alias bcl='brew list --cask'
alias bci='brew install --cask'
alias bcr='brew uninstall --cask'

# system
alias sd='doas'
alias sn='shutdown now'
#alias pi='python3 -m pip install --user --no-cache-dir'
#alias pu='python3 -m pip install --user -u'
#alias pr='python3 -m pip uninstall'

# rclone sec
alias rstuff='echo "syncing to drive" | cowsay -f tux && rclone sync -P ~/stuff/ drivec:/stuff/ '
alias rprojects='echo "syncing to cloud providers" | cowsay -f tux && rclone sync -P projects/ drivec:/projects/ --exclude ".git/**" --exclude "site/**" && echo && rclone sync -p projects/ blazec:/projects/ --exclude ".git/**" --exclude "site/**"'

# text editors
alias v='vim'
alias e='nvim'
alias vimrc='vim ~/.vimrc'
alias nvimrc='nvim ~/.config/nvim/init.vim'
alias zshrc='nvim ~/.config/zsh/.zshrc'
alias bashrc='nvim ~/.bashrc'
alias fishrc='nvim ~/.config/fish/config.fish'

# vagrant sec
alias vu='vagrant up'
alias vh='vagrant halt'
alias vd='vagrant destroy'
alias vs='vagrant ssh'

# exa
alias ls='eza --color=always --group-directories-first' 
alias la='eza -a --color=always --group-directories-first'  
alias ll='eza -al --color=always --group-directories-first' 
alias l.='eza -a | egrep "^\."'

# git
alias pullmain='git pull github main && sleep 5 && git pull gitlab main'
alias pushmain='git push github main && sleep 5 && git push gitlab main'
alias pullmaster='git pull github master && sleep 5 && git pull gitlab master'
alias pushmaster='git push github master && sleep 5 && git push gitlab master'
alias pullwork='git pull github workstation && sleep 5 && git pull gitlab workstation'
alias pushwork='git push github workstation && sleep 5 && git push gitlab workstation'
alias pusharch='git push github arch && sleep 5 && git push gitlab arch'
alias pullarch='git pull github arch && sleep 5 && git pull gitlab arch'
alias add='git add .'
alias commit='git commit -s -m'
alias rcommit='git commit --no-gpg-sign -m'
alias tlog='git log --graph --oneline --branches'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias fetch='git fetch'
alias pullit='git pull origin'
alias pushit='git push origin'
alias tag='git tag'
alias newtag='git tag -a'
alias gits='git secret'

# kubectl
alias k='kubectl'
# complete -f __start_kubectl k

# others
alias sudo='doas'
alias gt='gpg2 --card-status'
alias sa='ssh-add ~/.ssh/id_ed25519'
alias sz='ssh zeta@10.86.229.1'
alias yt='ykman list'
alias yd='youtube-dl'
alias btop='btop'
alias ctop='docker run --rm -ti --name=ctop --volume /var/run/docker.sock:/var/run/docker.sock:ro quay.io/vektorlab/ctop:latest'
alias dc='docker'
alias wu='doas wg-quick up wg0'
alias wd='doas wg-quick down wg0'
alias wr='doas systemctl restart wg-quick@wg0'
alias tb="nc termbin.com 9999"  # usage [echo "hello world" | tb] , [cat file | tb]
alias clearclip="xsel -bc"

# custom functions
## ex - archive extractor
## usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xjf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# render markdown files using glow with less as pager
md(){
    glow "$@" -s dark | less -r 
}

# invoke fetch master 6000
# $home/dotfiles/configurations/.config/fm6000/fm6000 -f $home/dotfiles/configurations/.config/fm6000/wolf.txt
