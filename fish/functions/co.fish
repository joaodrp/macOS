# Source: https://github.com/fatih/dotfiles
function co --description 'checkout default branch'
    git checkout (basename (git symbolic-ref refs/remotes/origin/HEAD)) $argv
end
