#             _
#     _______| |__  _ __ ___
#    |_  / __| '_ \| '__/ __|
#     / /\__ \ | | | | | (__
#    /___|___/_| |_|_|  \___|
#    
# source - https://github.com/sdatth/dotfiles


## Dependencies for zsh 
#    zsh                      > ZSH Shell
#    zsh-syntax-highlighting  > syntax highlighting for ZSH in standard repos
#    autojump                 > jump to directories with j or jc for child or jo to open in file manager
#    zsh-autosuggestions      > Suggestions based on your history
#
# config file location "~/.zshrc"
# see /usr/share/doc/zsh/examples/zshrc for examples

# to start tmux automatically when tmux launches
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  tmux -u
fi


setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt ksharrays           # arrays start at 0
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
export PROMPT_EOL_MARK=""

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[C' forward-word                       # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[D' backward-word                      # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[Z' undo                               # shift + tab undo last action

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# force zsh to show the complete history
alias history="history 0"

# plugins
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/autojump/autojump.zsh 
[ -f ~/.local/ubin/kubectl ] && source <(kubectl completion zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


## aliases
# navigation
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Merge Xresources
alias merge='xrdb -merge ~/.Xresources'

# system & update sec
alias au='sudo apt update'
alias aU='sudo apt upgrade'
alias ai='sudo apt install'
alias fu='flatpak update'
alias fU='flatpak uninstall --unused'
alias ar='sudo apt --purge remove'
alias ssn='sudo shutdown now'
alias sr='sudo reboot'
alias sd='sudo'
alias sn='shutdown now'
alias ua='bash ~/Stuff/projects/configs/shell-scripts/startup.sh'
alias pi='python3 -m pip install --user --no-cache-dir'
alias pu='python3 -m pip install --user -U'
alias pr='python3 -m pip uninstall'

# rclone sec
alias rfiles='echo "Syncing to drive" | cowsay -f tux && rclone sync -P files/ drivec:/files/ --exclude ".git/**" --exclude ".gitsecret/**" '
alias rcloud='echo "Syncing to drive" | cowsay -f tux && rclone sync -P dropbox/ drivec:/dropbox/'
alias revfiles='echo "Syncing to localhost" | cowsay -f tux && rclone sync -P drivec:/files/ files/ --exclude ".git/**" --exclude ".gitsecret/**" '
alias revcloud='echo "Syncing to localhost" | cowsay -f tux && rclone sync -P drivec:/dropbox/ dropbox/'
alias rdrop='echo "Syncing to both cloud providers" | cowsay -f tux && rclone sync -P dropbox/ db:/unsec/ && echo "" && rclone sync -P dropbox/ drivec:/dropbox/'
alias revdrop='echo "Syncing to localhost" | cowsay -f tux && rclone sync -P db:/unsec/ dropbox/'
alias rprojects='echo "Syncing to localhost" | cowsay -f tux && rclone sync -P projects/ drivec:/projects/ --exclude ".git/**" --exclude "site/**" '
alias revprojects='echo "Syncing to localhost" | cowsay -f tux && rclone sync -P drivec:/projects/ projects/ --exclude ".git/**" --exclude "site/**" '

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
alias commit='git commit -S -m'
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
# complete -F __start_kubectl k

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

# custom zsh completions
fpath=$HOME/.zsh_functions

# other program configs
FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export BAT_PAGER="less -R"

# fzf configs
export FZF_DEFAULT_OPTS="--no-mouse --height 70% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview'"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow -E libreoffice -E plugged -E coc -E google-chrome -E Code -E .git -E tor -E .local -E .vscode -E .npm -E oth -E snap -E .cache -E .zoom -E .vim -E node_modules  -E .ansible -E .anydesk -E .atom -E .clamtk -E .fzf -E .gem -E .gnupg -E ipython -E .joplin -E .jupyter -E .mozilla -E .npm -E .password-store -E .pki -E .ssh -E .var -E .vagrant.d -E vagrant  "
export FZF_CTRL_T_COMMAND="fd --type f --hidden --follow -E libreoffice -E plugged -E coc -E google-chrome -E Code -E .git -E tor -E .local -E .vscode -E .npm -E oth -E snap -E .cache -E .zoom -E .vim -E node_modules  -E .ansible -E .anydesk -E .atom -E .clamtk -E .fzf -E .gem -E .gnupg -E ipython -E .joplin -E .jupyter -E .mozilla -E .npm -E .password-store -E .pki -E .ssh -E .var -E .vagrant.d  -E vagrant " 
# export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
#export PATH=$PATH:$HOME/.local/bin

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xJf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

md(){
    glow "$@" -s dark | less -r 
}

# invoke fetch master 6000
# $HOME/dotfiles/configurations/.config/fm6000/fm6000 -f $HOME/dotfiles/configurations/.config/fm6000/wolf.txt

# uncomment the below line to use starship prompt
eval "$(starship init zsh)"
