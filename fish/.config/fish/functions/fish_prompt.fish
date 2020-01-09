function fish_prompt
    set_color $fish_color_cwd
    set_color blue
    set -U fish_prompt_pwd_dir_length 0
    echo -n "<$USER "
    echo -n (prompt_pwd)"> fish "
    echo -e \a
end
