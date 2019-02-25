function fish_prompt
    set_color $fish_color_cwd
    set_color green
    set -U fish_prompt_pwd_dir_length 0
    echo -n "<$USER "
    echo -n (prompt_pwd)"> "
    echo -e \a
end
