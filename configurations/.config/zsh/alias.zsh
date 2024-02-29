## aliases
# navigation
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# system & update sec
alias pi='python3 -m pip install --user --no-cache-dir'
alias pu='python3 -m pip install --user -u'
alias pre='python3 -m pip uninstall'

# brew
alias bu='brew update'
alias bU='brew upgrade'
alias bgc='brew cleanup && brew autoremove'
alias bl='brew leaves'
alias bi='brew install'
alias br='brew uninstall'
alias blc='brew list --cask'
alias bic='brew install --cask'
alias brc='brew uninstall --cask'
alias buc='brew upgrade --cask $(brew list --cask)'
alias boc='brew outdated --cask --greedy --verbose'

# screen
alias ss='screen -S'
alias sr='screen -r'
alias sl='screen -ls'

# rclone sec
alias rstuff='rclone sync -P ~/stuff/ drivec:/stuff/ --exclude ".DS_Store" '
alias revstuff='echo "syncing to localhost" | cowsay -f tux && rclone sync -p drivec:/stuff/ ~/Stuff/ '

# text editors
alias v='vim'
alias e='nvim'
alias vimrc='vim ~/.vimrc'
alias nvimrc='nvim ~/.config/nvim/init.vim'
alias zshrc='nvim ~/.zshrc'
alias bashrc='nvim ~/.bashrc'

# eza
alias ls='eza --color=always --group-directories-first'
alias la='eza -a --color=always --group-directories-first'
alias ll='eza -al --color=always --group-directories-first'
alias l.='eza -a | egrep "^\."'

# git
alias pull='git pull github mac && sleep 5 && git pull gitlab mac'
alias push='git push github mac && sleep 5 && git push gitlab mac'
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
alias sshadd='ssh-add ~/.ssh/id_ed25519'
alias gt='gpg2 --card-status'
alias yt='ykman list'
alias ctop='docker run --rm -ti --name=ctop --volume /var/run/docker.sock:/var/run/docker.sock:ro quay.io/vektorlab/ctop:latest'
alias tb="nc termbin.com 9999"  # usage [echo "hello world" | tb] , [cat file | tb]
alias clearclip="xsel -bc"
alias sourcez='source ~/.zshrc'
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
