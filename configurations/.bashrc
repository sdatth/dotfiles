# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
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
alias ua='bash ~/Stuff/files/configs/shell-scripts/startup.sh'

# rclone sec
alias rfiles='echo "Syncing to drive" | cowsay -f tux && rclone sync -P files/ drivec:/files/ --exclude ".git/**" --exclude ".gitsecret/**" '
alias rcloud='echo "Syncing to drive" | cowsay -f tux && rclone sync -P dropbox/ drivec:/dropbox/'
alias revfiles='echo "Syncing to localhost" | cowsay -f tux && rclone sync -P drivec:/files/ files/ --exclude ".git/**" --exclude ".gitsecret/**" '
alias revcloud='echo "Syncing to localhost" | cowsay -f tux && rclone sync -P drivec:/dropbox/ dropbox/'
alias rdrop='echo "Syncing to both cloud providers" | cowsay -f tux && rclone sync -P dropbox/ db:/unsec/ && echo "" && rclone sync -P dropbox/ drivec:/dropbox/'
alias revdrop='echo "Syncing to localhost" | cowsay -f tux && rclone sync -P db:/unsec/ dropbox/'

# text editors
alias v='vim'
alias e='nvim'
alias vimrc='vim ~/.vimrc'
alias nvimrc='nvim ~/.config/nvim/init.vim'
alias zshrc='nvim ~/.zshrc'

# vagrant sec
alias vu='vagrant up'
alias vh='vagrant halt'
alias vd='vagrant destroy'
alias vs='vagrant ssh'

# exa
alias ls='exa -l --color=always --group-directories-first' # my preferred listing 
alias la='exa -a --color=always --group-directories-first'  # all files and dirs 
alias ll='exa -l --color=always --group-directories-first'  # long format 
alias l.='exa -a | egrep "^\."'

# git
alias pull='git pull github main && sleep 5 && git pull gitlab main'
alias push='git push -u github main && sleep 5 && git push -u gitlab main'
alias add='git add .'
alias commit='git commit -S -m'
alias rcommit='git commit -m'
alias status='git status'

# others
alias gt='gpg2 --card-status'
alias yt='ykman list'
alias yd='youtube-dl'
alias btop='bpytop'
alias dc='sudo docker'
alias wu='sudo wg-quick up wg0'
alias wd='sudo wg-quick down wg0'
alias ll='ls -la'
alias l='ls -CF'
alias tb="nc termbin.com 9999"  # usage [echo "hello world" | tb] , [cat file | tb]


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(starship init bash)"
