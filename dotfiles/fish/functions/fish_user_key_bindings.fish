function fish_user_key_bindings
    #Need to use commandline to complete the execution and return a new line
    bind \ey -M insert 'yy; commandline -f execute'
    bind \ey 'yy; commandline -f execute'

    bind \eg -M insert 'lazygit; commandline -f execute'
    bind \eg 'lazygit; commandline -f execute'
end
