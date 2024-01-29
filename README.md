# dotfiles

![machfiles image](./extra/ss.png)

## Installing

!!! Note: We have a separate branch for mac install. Please check that out for macOS.

You will need `make` 

Clone into your `$HOME` directory or `~`

```bash
git clone https://github.com/sdatth/dotfiles.git $HOME/
# OR
git clone https://gitlab.com/sdatth/dotfiles.git $HOME/
```

Run the command to install necessary packages for your distributions
```bash
make [arch|debian|ubuntu|freebsd|rhel]
```

Use the help recipe to see available options
```bash
make help
```
