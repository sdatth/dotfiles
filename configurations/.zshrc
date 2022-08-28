#             _
#     _______| |__  _ __ ___
#    |_  / __| '_ \| '__/ __|
#     / /\__ \ | | | | | (__
#    /___|___/_| |_|_|  \___|
#    
# source - https://github.com/sdatth/dotfiles

#if command -v tmux &> /dev/null && [ -n "$ps1" ] && [[ ! "$term" =~ screen ]] && [[ ! "$term" =~ tmux ]] && [ -z "$tmux" ]; then
#  tmux -u
#fi

#if [ -z $TMUX ]; then; tmux; fi

export ZDOTDIR=$HOME/.config/zsh
 
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

# Setting for the new UTF-8 terminal support in Lion
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

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
source "$ZDOTDIR/autojump.sh"
source "$HOME/.nix-profile/share/fzf/key-bindings.zsh"
source "$ZDOTDIR/alias.zsh"
# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"


FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export BAT_PAGER="less -R"

# fzf configs
export FZF_DEFAULT_OPTS="--no-mouse --height 70% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview'"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow  -E .kube -E .cache -E Library -E Applications -E .tsh -E Movies -E Pictures -E borg -E Music -E .zsh_sessions -E .vscode-server -E libreoffice -E .nix-defexpr -E.nix-profile -E plugins -E plugged -E coc -E google-chrome -E Code -E .git -E tor -E .local -E .vscode -E .npm -E oth -E snap -E .cache -E .vim -E node_modules  -E .ansible -E .anydesk -E .atom -E .clamtk -E .fzf -E .gem -E .gnupg -E ipython -E .joplin -E .jupyter -E .mozilla -E .npm -E .password-store -E .pki -E .ssh -E .var -E .vagrant.d -E vagrant  "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

if [ -e /home/zeta/.nix-profile/etc/profile.d/nix.sh ]; then . /home/zeta/.nix-profile/etc/profile.d/nix.sh; fi
eval "$(starship init zsh)"
