function upgrade -d "update and upgrade brew, fish, fisher and mac app store"
    echo 'start updating ...'

    echo 'updating homebrew'
    brew update
    brew upgrade --greedy
    brew cleanup

    echo 'updating fish shell'
    fisher update
    fish_update_completions

    echo 'updating app store apps'
    mas upgrade
end
