# Dotfiles

My dotfiles for Linux.

![A screenshot of my desktop](screenshot.png)

## Installation

The dotfiles are managed by [GNU Stow](https://www.gnu.org/software/stow/), so installation and management is simple!

### Download

`git clone https://github.com/adamrutter/dotfiles.git`

### Install a specific configuration

Change to the dotfiles directory, and:

`stow awesome`

## Notes

### Colour scheme

The colour cheme is kept uniform across the desktop, and is very easy to change. Pywal generates the colour scheme.

### Awesome

Awesome generates a more complex pallete of tints/shades for all Xresources colors. A base accent colour is explicitly picked in `theme.lua` (`color1` for example), tints/shades of which are then used throughout.

Dependencies for my Awesome config are:

- `rofi`
- `pamixer`

My setup was inspired by [adi1090x's polybar-themes](https://github.com/adi1090x/polybar-themes), [elenapan's Awesome setup](https://github.com/elenapan/dotfiles), and [material-awesome](https://github.com/HikariKnight/material-awesome). Go check out their work!

### GTK

A custom variant of [Arc](https://github.com/jnsh/arc-theme) is used. Checkout [my Arc repo](https://github.com/adamrutter/arc-theme) for the script I use to build Arc variants. I run the `gsd-xsettings` daemon in `xinitrc` so I can hot reload the GTK theme.
