# Dotfiles

My dotfiles for Linux. Includes custom configuration for:

* Atom
* Bash 
* Compton  
* Dunst  
* Firefox  
* Fish  
* Fonts  
* GTK 
* i3 
* Mousepad  
* Polybar 
* Redshift  
* Rofi  
* Vim  
* VLC  
* X
* zsh

## Installation

The dotfiles are managed by [GNU Stow](https://www.gnu.org/software/stow/), so installion and management is simple!

### Download

`git clone https://github.com/adamrutter/dotfiles.git`

### Install a specific configuration

Change to the dotfiles directory, and:

`stow atom`

### Install everything


Change to the dotfiles directory, and:

`stow *`

## Notes

### Accent colour

The accent colour is kept uniform across all programs. This requires editing:

* The GTK theme (see [here](#gtk))
* The `*accent` variable in `x/.Xresources`
* The `--accent-color` variable in `firefox/.mozilla/firefox/$YOUR_PROFILE/chrome/userChrome.css`
* The `@accent` variable in `atom/.atom/styles.less` for Atom
* The custom fish prompt in `fish/.config/fish/functions/fish_prompt.fish`
* The custom bash prompt in `bash/.bashrc`
* `frame_color` in `dunst/.config/dunst/dunstrc` (Note: edit the one under the `[global]` heading, not under `[urgency_critical]`)

This is probably something I will automate in future with a script.

### GTK

A custom variant of the popular Arc theme is used, generated by [this](https://github.com/erikdubois/Arc-Theme-Colora) fantastic script.

### Polybar

My Polybar shows workspace indicators to the left, and a system tray area to the right. The system tray contains a weather indicator, volume control, clock and power menu. 

Perhaps most interestingly, the system tray also contains an indicator that reports whether the filesystem of my phone is currently mounted. I wrote a script that automatically mounts the filesystem using [sshfs](https://github.com/libfuse/sshfs) when my phone is on the home network, and it is useful to be able to see the status at a glance.

### Rofi

A clickable button for Rofi is at the extreme left of my Polybar. Click it, or use the keybinding, and it will _extend_ from the left hand side. In reality, Rofi is just overlayed on top of Polybar, but I like the effect!
