#!/usr/bin/env sh

# Process arguments
for i in "$@"; do
  case "$i" in
    -h|--help)
      echo "Usage: $(basename "$0") [-h|--help] [-t|--theme] [-i|--icons]
Change the current GTK theme using gsettings.

-h, --help    Show this help
-t, --theme   The new GTK theme (eg, -t=\"Arc-Dark\")
-i, --icons   The new icon theme (eg, -i=\"Papirus\")
"
      exit 1
      ;;
    -t=*|--theme=*)
      theme="${i#*=}"
      shift
      ;;
    -i=*|--icons=*)
      icons="${i#*=}"
      shift
      ;;
  esac
done

# Change theme
[[ ! -z "$theme" ]] && gsettings set org.gnome.desktop.interface gtk-theme "$theme" || :

# Change icons
[[ ! -z "$icons" ]] && gsettings set org.gnome.desktop.interface icon-theme "$icons" || :
