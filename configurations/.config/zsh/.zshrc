#             _
#     _______| |__  _ __ ___
#    |_  / __| '_ \| '__/ __|
#     / /\__ \ | | | | | (__
#    /___|___/_| |_|_|  \___|
#    
# source - https://github.com/sdatth/dotfiles

# source brew bin
[ -d "/home/linuxbrew" ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

## TMUX
if command -v tmux >/dev/null 2>&1; then
  if [[ -z "$TMUX" && -n "$PS1" && -z "$ZSH_AUTOSTARTED_TMUX" ]]; then
    export ZSH_AUTOSTARTED_TMUX=1
    if tmux has-session 2>/dev/null; then
      exec tmux attach-session
    else
      exec tmux new-session
    fi
  fi
fi

export ZDOTDIR=$HOME/.config/zsh

# GPG prompt feature
export GPG_TTY=$(tty)

# custom bin path
export PATH=$PATH:$HOME/.bin


# Start ssh-agent if it's not already running
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(ssh-agent -s) &>/dev/null
    if [ -f $HOME/.ssh/dev_key ]; then
      ssh-add $HOME/.ssh/dev_key &>/dev/null
    fi  
fi



# ~/.local/bin path
if [ -d $HOME/.local/bin ] ; then
    export PATH=$PATH:$HOME/.local/bin
fi    

# colour theme to work inside screen
export TERM=xterm-256color

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
HISTFILE=$HOME/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
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

# source alias file if doas exist
if which doas > /dev/null 2>&1; then
    source "$ZDOTDIR/alias.zsh"
fi

# source distrobox funtions
if which distrobox > /dev/null 2>&1; then
    source "$ZDOTDIR/zen.zsh"
fi

### fzf
# arch
[[ -s /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -s /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh

# brew
[[ -d /home/linuxbrew/.linuxbrew/opt/fzf/ ]] && export PATH="${PATH:+${PATH}:}/home/linuxbrew/.linuxbrew/opt/fzf/bin"
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
#zsh_add_plugin "marlonrichert/zsh-autocomplete"

# bind key 
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export BAT_PAGER="less -R"

# fzf configs
export FZF_DEFAULT_OPTS="--no-mouse --height 70% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview'"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow -E docker -E @trezor -E 'Code - OSS' -E chromium -E .cargo -E .vscode-oss -E tor-browser -E .tldrc -E Microsoft -E BraveSoftware -E .kube -E .cache -E Library -E Applications -E .tsh -E Movies -E Pictures -E borg -E Music -E .zsh_sessions -E .vscode-server -E libreoffice -E .nix-defexpr -E.nix-profile -E plugins -E plugged -E coc -E google-chrome -E Code -E .git -E tor -E .local -E .vscode -E .npm -E oth -E snap -E .cache -E .vim -E node_modules  -E .ansible -E .anydesk -E .atom -E .clamtk -E .fzf -E .gem -E .gnupg -E ipython -E .joplin -E .jupyter -E .mozilla -E .npm -E .password-store -E .pki -E .ssh -E .var -E .vagrant.d -E vagrant  "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

# start zoxide
if which zoxide > /dev/null 2>&1; then
    eval "$(zoxide init --cmd cd zsh)"
fi

# start starship
if which starship > /dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
