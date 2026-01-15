# Source: https://github.com/fatih/dotfiles
function cdr --description 'cd to git repository root'
    cd (git rev-parse --show-toplevel) $argv
end
