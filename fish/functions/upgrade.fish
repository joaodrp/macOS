function upgrade -d "update and upgrade brew, fish, fisher and mac app store"
    echo ''
    echo (set_color --bold blue)':: Updating Homebrew'(set_color normal)
    brew update
    brew upgrade --greedy
    brew cleanup

    echo ''
    echo (set_color --bold blue)':: Updating Fish shell'(set_color normal)
    fisher update
    fish_update_completions

    echo ''
    echo (set_color --bold blue)':: Updating App Store apps'(set_color normal)
    mas upgrade

    echo ''
    echo (set_color --bold blue)':: Updating Claude npx packages'(set_color normal)
    for cmd in (grep -v '^#' ~/.claude/npx-packages.txt 2>/dev/null | grep -v '^$')
        eval npx $cmd
    end

    echo ''
    echo (set_color --bold blue)':: Updating Claude marketplaces'(set_color normal)
    claude plugin marketplace update

    echo ''
    echo (set_color --bold blue)':: Updating Claude plugins'(set_color normal)
    for plugin in (grep -v '^#' ~/.claude/plugins.txt 2>/dev/null | grep -v '^$')
        claude plugin install $plugin 2>&1; or true
    end
end
