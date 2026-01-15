# Source: https://github.com/fatih/dotfiles
function hc --description 'Open PR in browser'
    gh pr view --web $argv
end
