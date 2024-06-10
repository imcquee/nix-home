if status is-interactive
    zoxide init --cmd cd fish | source
    eval (zellij setup --generate-auto-start fish | string collect)
end
