# dotfiles

![machfiles image](./extra/ss.png)

!! Warning, this only works on ubuntu/debain distributions. It has been tested on ubuntu 20.04 only! <br> 
!! Other people can inspect and manually copy the elements of the files! 

## Installing

You will need `make` 

Clone into your `$HOME` directory or `~`

```bash
git clone https://github.com/sdatth/dotfiles.git $HOME/
# OR
git clone https://gitlab.com/sdatth/dotfiles.git $HOME/
```

Run this command to install the nix package manager.
```bash
cd dotfiles
make nix
```
(Note ! - Restart your shell for nix to work right)

Run the command to install necessary packages and stow my config
```bash
make copy
```

Use the help recipe to see available options
```bash
make help
```
