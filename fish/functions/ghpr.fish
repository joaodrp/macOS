# Source: https://github.com/fatih/dotfiles
function ghpr --description 'Push and create PR'
    git push -u origin
    gh pr create --web
end
