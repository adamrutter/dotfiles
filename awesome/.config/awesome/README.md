# My Awesome config

My Awesome setup allows me to very easily generate _beautiful_ `( ͡~ ͜ʖ ͡°)` colour schemes for every element of the desktop (including Awesome, GTK and icon themes, and Rofi), and hot reload all elements for a seamless experience.

## Hot reloading

The colour scheme is kept uniform across the desktop, and is very easy to change. A script I wrote, [`theme.sh`](../../../bin/bin/theme.sh), generates colours using pywal, and takes the accent colour provided by the user and applies it to the window manager, the GTK theme, the icon theme, Rofi, and the terminal; just give it a wallpaper and an Xresources colour to use as an accent and it's off! I'll go into more detail about how it does this below...

### Pywal

Pywal runs and does its usual thing, generating a colour scheme from the provided wallpaper.

### Awesome

The script emits some custom events using `awesome-client` that are listened for in the main Awesome config.

First, it tells Awesome that Xresources has changed. Awesome can then generate tints and shades from Xresources for its own use.

The script then updates `beautiful.accent` with the accent colour you provided it.

Finally, the script emits an event Awesome uses to hot reload elements with these new colours.

### GTK/Icon themes

As it's not possible to simply set a new colour for GTK or icon themes, the script will actually build a new variant for the chosen accent colour.

Variants of the GTK theme are created with the help of a [script](../../../bin/bin/arc-color-change.sh) I wrote that modifies the accent colour in the theme source files. `theme.sh` can then build the new variant.

First, `theme.sh` will check if a variant for this accent already exists and, if it does, hot reload it using `gsettings`. If it doesn't, it will prompt the user, build one (this will take a minute or two), and hot reload using `gsettings` ([more info here on hot reloading GTK/icons](https://github.com/deviantfero/wpgtk/issues/112)).

### Rofi

Pywal supports Rofi natively, but it has no concept of what our accent colour is, so we use `perl` to update Rofi's `accent.rasi`.

## Setting this up for yourself

I'm using the stable release of Awesome (4.3), so first install that using your distribution's package manager

### Dependencies

#### Install these packages using your distribution's package manager

- `rofi`
- `pamixer`
- `papirus-icon-theme`
- `gnome-settings-daemon`
- `feh`

#### Install these projects by following the included notes

##### `pywal`

Follow the [installation instructions](https://github.com/dylanaraps/pywal/wiki/Installation) for your distibution in the pywal wiki.

Also install the colorz backend for pywal `pip install colorz`, or edit `bin/theme.sh` to use a different backend.

Make sure you follow the [Applying the theme to new terminals](https://github.com/dylanaraps/pywal/wiki/Getting-Started#applying-the-theme-to-new-terminals) section, too.

##### `arc-theme`

`git clone https://github.com/jnsh/arc-theme.git .arc-theme`

This is all you need to do for the GTK theme. My `theme.sh` script will sort the rest for you.

You could use a different GTK theme, but you won't be able to hot reload any GTK elements without creating your own reload flow. The hot reload flow is written about above.

##### Font Awesome 5 Pro

The icon font used. You might be able to find this in your distribution's repo, but it's likely more hit or miss than the packages listed above.

You can use a different icon font, just change the icon font in Awesome's `theme.lua`. You will almost certainly have to change each icon character where it is defined, too (usually in the widget's file).

### Setup

#### Config files

**Remember to make backups of any existing config files!**

Now you've installed the dependencies, we can get going. To make installation easier, install `stow` using your distribution's package manager.

- `cd ~`
- `git clone https://github.com/adamrutter/dotfiles.git`
- `cd dotfiles`
- `echo "* { accent: #ff00ff; }" > rofi/.config/rofi/accent.rasi`
- `stow awesome rofi`
- `cp bin/bin/arc-color-change.sh bin/bin/change_gtk.sh bin/bin/theme.sh ~/bin`

#### Create a theme

Now, set up a theme using `theme.sh`. Use `theme.sh --help` to print usage info. **Note**, `theme.sh` assumes your wallpapers are going to be stored in `~/pictures/wallpapers`, just edit the script to use the correct path if this is not the case.

You won't see any drastic changes yet because we haven't started Awesome, so let's fix that.

#### Startup process

Add the following lines to the bottom of your `.xinitrc` **(These lines must be in this order!)**:

- `/usr/lib/gsd-xsettings &`
- `~/bin/theme.sh $(cat ~/.cache/theme_wallpaper) $(cat ~/.cache/theme_accent_name)`
- `exec awesome`

This will start `gsettings` (allowing us to hot reload GTK/icon themes), run the theme script using the last used parameters, and start Awesome.

#### Done!

You can now restart the X server, and you should be presented with my setup. Some final notes:

- `super+f1` will bring up my Awesome key bindings
- `super+enter` for a terminal (you may need to edit Awesome's `rc.lua` and specify your terminal of choice)
- `super+space` for Rofi

Why not try creating some more themes now Awesome is running!
