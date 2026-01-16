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
    while read -l cmd
        npx $cmd
    end <~/.claude/npx-packages
end
