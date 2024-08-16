if status is-interactive
    zoxide init --cmd cd fish | source
end

function original_cd
    builtin cd $argv
end

alias ls "lsd -t --blocks git,name,size,date --date '+%b %-d, %Y %I:%M%P'"
alias cat "bat -p"
alias lg "zellij run -cf --width 80% --height 80% --x 10% --y 10% -- lazygit"
alias zj zellij
alias ff fastfetch

set -gx EDITOR nvim

starship init fish | source
