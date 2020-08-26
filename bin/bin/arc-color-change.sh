#!/usr/bin/env bash

# Process arguments
for i in "$@"; do
  case "$i" in
    -h|--help)
      echo "Usage: $(basename "$0") [-h|--help] [-s|--source] [-b|--background] [-f|--foreground]
Changes the accent color of Arc.

-h, --help          Show this help
-s, --source        The path to Arc (eg, s=~/.arc-theme)
-b, --background    The new accent color (eg, -b=\"#aa5d4f\")
-f, --foreground    The color for text used with the accent color (eg, -f=\"#ffffff\")
"
      exit 0
      ;;
    -s=*|--source=*)
      # Set variable
      eval source="${i#*=}"
      # Verify source directory
      if [[ -d "$source" ]]; then
        shift
      else
        echo "Could not find given source directory: $source"
        exit 1
      fi
      ;;
    -f=*|--foreground=*)
      # Set variable
      new_fg_color="${i#*=}"
      # Verify foreground is a hex color value
      if [[ "${new_fg_color:1:7}" =~ ^([[:xdigit:]]{3}){1,2}$ ]]; then
        shift
      else
        echo "Not a valid hex color: $new_fg_color"
        exit 1
      fi
      ;;
    -b=*|--background=*)
      # Set variable
      new_bg_color="${i#*=}"
      # Verify background is a hex color value
      if [[ "${new_bg_color:1:7}" =~ ^([[:xdigit:]]{3}){1,2}$ ]]; then
        shift
      else
        echo "Not a valid hex color: $new_bg_color"
        exit 1
      fi
      ;;
    *)
      echo "You passed an unknown argument: $i"
      exit 1
    ;;
  esac
done

# Must pass a --source argument
if [[ ! $source ]]; then
  echo "You need to point the script to where the source files are located. Use the --source argument"
  exit 1
fi

# The current colors in the theme
current_bg_color=$(grep "selected_bg_color" $source/common/gtk-3.0/3.18/sass/_colors.scss | head -1 | grep -Eo "(#[[:xdigit:]]{6}){1,2}")
current_fg_color=$(grep "selected_fg_color" $source/common/gtk-3.0/3.18/sass/_colors.scss | head -1 | grep -Eo "(#[[:xdigit:]]{6}){1,2}")

# Use the current color if one wasn't supplied as an argument
new_bg_color="${new_bg_color:-$current_bg_color}"
new_fg_color="${new_fg_color:-$current_fg_color}"

# The files to edit
files=(
  "$source/common/gtk-2.0/dark/assets.svg"
  "$source/common/gtk-2.0/dark/gtkrc"
  "$source/common/gtk-2.0/darker/gtkrc"
  "$source/common/gtk-2.0/light/assets.svg"
  "$source/common/gtk-2.0/light/gtkrc"
  "$source/common/gtk-2.0/lighter/gtkrc"
  "$source/common/gtk-3.0/3.18/assets.svg"
  "$source/common/gtk-3.0/3.18/sass/_colors.scss"
  "$source/common/gtk-3.0/3.20/assets.svg"
  "$source/common/gtk-3.0/3.20/sass/_colors.scss"
  "$source/common/gtk-3.0/3.22/assets.svg"
  "$source/common/gtk-3.0/3.22/sass/_colors.scss"
  "$source/common/gtk-3.0/3.24/assets.svg"
  "$source/common/gtk-3.0/3.24/sass/_colors.scss"
)

# Change the accent color in each file
for i in "${files[@]}"; do
  echo "Overwriting $i..."
  # Different find/replace for each type of file
  case $(basename "$i") in
    "_colors.scss")
      perl -p -i -e "s/(?<=selected_fg_color:)\s*(#[[:xdigit:]]{6})/ $new_fg_color/g" "$i"
      perl -p -i -e "s/(?<=selected_bg_color:)\s*(#[[:xdigit:]]{6})/ $new_bg_color/g" "$i"
      ;;
    "gtkrc")
      perl -p -i -e "s/(?<=selected_fg_color:)\s*(#[[:xdigit:]]{6})/ $new_fg_color/g" "$i"
      perl -p -i -e "s/(?<=selected_bg_color:)\s*(#[[:xdigit:]]{6})/ $new_bg_color/g" "$i"
      perl -p -i -e "s/(?<=link_color:)\s*(#[[:xdigit:]]{6})/ $new_bg_color/g" "$i"
      ;;
    "assets.svg")
      perl -p -i -e "s/$current_fg_color/$new_fg_color/g" "$i"
      perl -p -i -e "s/$current_bg_color/$new_bg_color/g" "$i"
  esac
done

echo "Done!"

