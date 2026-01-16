#!/bin/bash
[ ! -f "$HOME/.profile" ] && touch $HOME/.profile
if which brew > /dev/null 2>&1; then
    echo "Brew package manager already exist"
    exit 0
elif [[ "$(uname)" == "Linux" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ "$(uname)" == "Darwin" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.profile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
