#             _
#     _______| |__  _ __ ___
#    |_  / __| '_ \| '__/ __|
#     / /\__ \ | | | | | (__
#    /___|___/_| |_|_|  \___|
#    
# source - https://github.com/sdatth/dotfiles

## TMUX
#if command -v tmux &> /dev/null && [ -n "$ps1" ] && [[ ! "$term" =~ screen ]] && [[ ! "$term" =~ tmux ]] && [ -z "$tmux" ]; then
#  tmux -u
#fi
#if [ -z $TMUX ]; then; tmux; fi

export ZDOTDIR=$HOME/.config/zsh

# GPG prompt feature
export GPG_TTY=$(tty)

# custom bin path
export PATH=$PATH:$HOME/.bin

# some useful options (man zshoptions)
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
# zstyle ':completion::complete:lsof:*' menu yes select
zmodload zsh/complist
# compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# history configurations
HISTFILE=~/.zsh_history
SAVEHIST=1000
savehist=2000
setopt hist_expire_dups_first # delete duplicates first when histfile size exceeds histsize
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify     
setopt appendhistory

# vi mode
bindkey -v
export KEYTIMEOUT=1
# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# Useful Functions
source "$ZDOTDIR/zsh-functions"
#source "$ZDOTDIR/autojump.sh"

# source alias file if doas exist
if which doas > /dev/null 2>&1; then
    source "$ZDOTDIR/alias.zsh"
fi

# source distrobox funtions
if which distrobox > /dev/null 2>&1; then
    source "$ZDOTDIR/distrobox-alias.zsh"
fi

### fzf
# arch
[[ -s /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -s /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh

# brew
if [[ ! "$PATH" == */home/linuxbrew/.linuxbrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/linuxbrew/.linuxbrew/opt/fzf/bin"
fi
[[ -s /home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.zsh ]] && source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.zsh"
[[ -s /home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.zsh ]] && source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.zsh"

# freeBSD
[[ -s /usr/local/share/examples/fzf/shell/completion.zsh ]] && source /usr/local/share/examples/fzf/shell/completion.zsh
[[ -s /usr/local/share/examples/fzf/shell/key-bindings.zsh ]] && source /usr/local/share/examples/fzf/shell/key-bindings.zsh 


# autojump
[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-history-substring-search"

# bind key 
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export BAT_PAGER="less -R"

# fzf configs
export FZF_DEFAULT_OPTS="--no-mouse --height 70% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview'"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow -E tor-browser -E .tldrc -E Microsoft -E BraveSoftware -E .kube -E .cache -E Library -E Applications -E .tsh -E Movies -E Pictures -E borg -E Music -E .zsh_sessions -E .vscode-server -E libreoffice -E .nix-defexpr -E.nix-profile -E plugins -E plugged -E coc -E google-chrome -E Code -E .git -E tor -E .local -E .vscode -E .npm -E oth -E snap -E .cache -E .vim -E node_modules  -E .ansible -E .anydesk -E .atom -E .clamtk -E .fzf -E .gem -E .gnupg -E ipython -E .joplin -E .jupyter -E .mozilla -E .npm -E .password-store -E .pki -E .ssh -E .var -E .vagrant.d -E vagrant  "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

# source brew bin
[ -d "/home/linuxbrew" ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# start starship
if which starship > /dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
