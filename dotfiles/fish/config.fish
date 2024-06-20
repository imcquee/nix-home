if status is-interactive
    zoxide init --cmd cd fish | source
end

function original_cd
    builtin cd $argv
end
