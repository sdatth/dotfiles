# dotfiles

![machfiles image](./ss.png)

!! Warning, install.sh script only works on ubuntu/debain distributions. It has been tested on ubuntu 20.04 only! <br> 
!! Other people can copy my config files or symlink it using the `stow` command.

## Installing

You will need `git` and GNU `stow`

Clone into your `$HOME` directory or `~`

```bash
git clone https://github.com/sdatth/dotfiles.git ~/
# OR
git clone https://gitlab.com/sdatth/dotfiles.git ~/
```

Run the bash script to install my configuration
```bash
cd dotfiles
chmod +x install.sh
bash install.sh
```

Symlink my config files
```bash
cd dotfiles
stow configurations/
```
