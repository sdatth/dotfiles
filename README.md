# dotfiles

![machfiles image](./extra/ss.png)

#### Note
- This is a script to get all my configurations, it will either install nix or brew package manager according to your choice.
- Only nix is supported for arm64.
- For MacOS the package manager is hardcoded as brew as it is the best one out there.

## One line Installation

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/sdatth/dotfiles/refs/heads/main/script.sh)
```

## Manual Installation

!!! You will need `make` or `gmake` (for macos & freebsd) package

Clone into your `$HOME` directory or `~`

```bash
git clone https://github.com/sdatth/dotfiles.git
# OR
git clone https://gitlab.com/sdatth/dotfiles.git
```

### Choose your package manager

(Note : Arm64 only has compatibility with nix)
(Note : Choose brew for macos for better compatibility)

```bash
make [brew|nix]  ## Linux Distros
gmake brew       ## MacOS
```

### For Linux Distros

```bash
make [arch|debian|ubuntu|rhel]
```

### For FreeBSD

```bash
gmake freebsd
```

### For MacOS

```bash
gmake mac
```

### Help

Use the help recipe to see available options
```bash
make help
```


#### Note Important:

This script will install files from
- zsh-autosuggestions plugin          : https://github.com/zsh-users/zsh-autosuggestions
- zsh-syntax-highlighting plugin      : https://github.com/zsh-users/zsh-syntax-highlighting
- zsh-history-substring-search plugin : https://github.com/zsh-users/zsh-history-substring-search

This repo contains code/files from other repo, they are the original authors for this
- Vim Plug        : https://github.com/junegunn/vim-plug
- Nerd Fonts      : https://www.nerdfonts.com/
- Autojump plugin : https://github.com/wting/autojump
