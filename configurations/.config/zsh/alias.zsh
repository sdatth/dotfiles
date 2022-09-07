## aliases
# navigation
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# merge xresources
alias merge='xrdb -merge ~/.xresources'

# system & update sec
alias au='sudo apt update'
alias aU='sudo apt upgrade'
alias ai='sudo apt install'
alias fu='flatpak update'
alias fu='flatpak uninstall --unused'
alias ar='sudo apt --purge remove'
alias ssn='sudo shutdown now'
alias sr='sudo reboot'
alias sd='sudo'
alias sn='shutdown now'
alias ua='bash ~/stuff/projects/configs/shell-scripts/startup.sh'
alias pi='python3 -m pip install --user --no-cache-dir'
alias pu='python3 -m pip install --user -u'
alias pr='python3 -m pip uninstall'

# rclone sec
alias rfiles='echo "syncing to drive & backblaze" | cowsay -f tux && rclone sync -p files/ drivec:/files/ && echo && rclone sync -p files/ blazec:/files/ ' 
alias rcloud='echo "syncing to drive" | cowsay -f tux && rclone sync -p dropbox/ drivec:/dropbox/'
alias revfiles='echo "syncing to localhost" | cowsay -f tux && rclone sync -p drivec:/files/ files/ '
alias revcloud='echo "syncing to localhost" | cowsay -f tux && rclone sync -p drivec:/dropbox/ dropbox/'
alias rdrop='echo "syncing to both cloud providers" | cowsay -f tux && rclone sync -p dropbox/ db:/unsec/ && echo && rclone sync -p dropbox/ drivec:/dropbox/'
alias revdrop='echo "syncing to localhost" | cowsay -f tux && rclone sync -p db:/unsec/ dropbox/'
alias rprojects='echo "syncing to cloud providers" | cowsay -f tux && rclone sync -p projects/ drivec:/projects/ --exclude ".git/**" --exclude "site/**" && echo && rclone sync -p projects/ blazec:/projects/ --exclude ".git/**" --exclude "site/**"'
alias revprojects='echo "syncing to localhost" | cowsay -f tux && rclone sync -p drivec:/projects/ projects/ --exclude ".git/**" --exclude "site/**" '

# text editors
alias v='vim'
alias e='nvim'
alias vimrc='vim ~/.vimrc'
alias nvimrc='nvim ~/.config/nvim/init.vim'
alias zshrc='nvim ~/.zshrc'
alias bashrc='nvim ~/.bashrc'
alias fishrc='nvim ~/.config/fish/config.fish'

# vagrant sec
alias vu='vagrant up'
alias vh='vagrant halt'
alias vd='vagrant destroy'
alias vs='vagrant ssh'

# exa
alias ls='exa --color=always --group-directories-first' 
alias la='exa -a --color=always --group-directories-first'  
alias ll='exa -al --color=always --group-directories-first' 
alias l.='exa -a | egrep "^\."'

# git
alias pull='git pull github main && sleep 5 && git pull gitlab main'
alias push='git push github main && sleep 5 && git push gitlab main'
alias pullmaster='git pull github master && sleep 5 && git pull gitlab master'
alias pushmaster='git push github master && sleep 5 && git push gitlab master'
alias add='git add .'
alias commit='git commit -s -m'
alias rcommit='git commit -m'
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
alias gt='gpg2 --card-status'
alias yt='ykman list'
alias yd='youtube-dl'
alias btop='bpytop'
alias ctop='docker run --rm -ti --name=ctop --volume /var/run/docker.sock:/var/run/docker.sock:ro quay.io/vektorlab/ctop:latest'
alias dc='docker'
alias wu='sudo wg-quick up wg0'
alias wd='sudo wg-quick down wg0'
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
