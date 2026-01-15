# Source: https://github.com/fatih/dotfiles
function fish_title --description 'Set terminal tab title to git root or current dir'
    set -l git_root (git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$git_root"
        basename "$git_root"
    else
        basename "$PWD"
    end
end
