# Source: https://github.com/fatih/dotfiles
function hb --description 'Open repo in browser'
    gh repo view --web $argv
end
