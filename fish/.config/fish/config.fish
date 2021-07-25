# Set path
set PATH /home/adam/bin $PATH

# Turn terminal bong off for TTY
# setterm -blength 0

# Set welcome message to empty/nothing
set fish_greeting

# Set vim as the default terminal editor
set -gx EDITOR vim

# Stop wine from adding filetype associations
set -gx WINEDLLOVERRIDES winemenubuilder.exe=d

# Pywal
cat /home/adam/.cache/wal/sequences

# Set fish color scheme to terminal colori scheme
set -U fish_color_autosuggestion      brblack
set -U fish_color_cancel              -r
set -U fish_color_command             brgreen
set -U fish_color_comment             brmagenta
set -U fish_color_cwd                 green
set -U fish_color_cwd_root            red
set -U fish_color_end                 brmagenta
set -U fish_color_error               brred
set -U fish_color_escape              brcyan
set -U fish_color_history_current     --bold
set -U fish_color_host                normal
set -U fish_color_match               --background=brblue
set -U fish_color_normal              normal
set -U fish_color_operator            cyan
set -U fish_color_param               brblue
set -U fish_color_quote               yellow
set -U fish_color_redirection         bryellow
set -U fish_color_search_match        'bryellow' '--background=brblack'
set -U fish_color_selection           'white' '--bold' '--background=brblack'
set -U fish_color_status              red
set -U fish_color_user                brgreen
set -U fish_color_valid_path          --underline
set -U fish_pager_color_completion    normal
set -U fish_pager_color_description   yellow
set -U fish_pager_color_prefix        'white' '--bold' '--underline'
set -U fish_pager_color_progress      'brwhite' '--background=cyan'

# pure prompt config
# https://github.com/pure-fish/pure 
set -U pure_symbol_prompt \>
set -U pure_symbol_reverse_prompt \<
set -U pure_symbol_git_unpulled_commits ↓
set -U pure_symbol_git_unpushed_commits ↑
set -U pure_symbol_git_stash %
set -U pure_color_success green
set -U pure_color_mute white

