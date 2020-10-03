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
if [[ -n "$theme" ]]; then
  gsettings set org.gnome.desktop.interface gtk-theme "$theme"
  echo "$theme" > "$HOME"/.cache/theme_gtk_theme
fi

# Change icons
if [[ -n "$icons" ]]; then
  gsettings set org.gnome.desktop.interface icon-theme "$icons"
  echo "$icons" > "$HOME"/.cache/theme_icon_theme
fi
