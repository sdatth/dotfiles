#!/bin/bash
[ ! -f "$HOME/.profile" ] && touch $HOME/.profile

# install brew package manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if command -v brew > /dev/null 2>&1; then
    echo "Brew package manager already exist"
    exit 0
fi

# install brew package manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [[ "$(uname)" == "Linux" ]]; then
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
elif [[ "$(uname)" == "Darwin" ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.profile
fi
