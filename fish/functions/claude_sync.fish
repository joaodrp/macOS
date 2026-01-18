function claude_sync -d "Sync Claude Code marketplaces and plugins from config files" -a prune
    # Add marketplaces
    echo (set_color --bold blue)':: Adding Claude marketplaces'(set_color normal)
    for repo in (grep -v '^#' ~/.claude/marketplaces.txt 2>/dev/null | grep -v '^$')
        claude plugin marketplace add $repo 2>&1; or true
    end

    # Update marketplaces
    echo ''
    echo (set_color --bold blue)':: Updating Claude marketplaces'(set_color normal)
    claude plugin marketplace update

    # Prune marketplaces not in config
    if test "$prune" = --prune
        echo ''
        echo (set_color --bold blue)':: Pruning unlisted marketplaces'(set_color normal)
        set -l desired_repos (grep -v '^#' ~/.claude/marketplaces.txt 2>/dev/null | grep -v '^$')
        for entry in (claude plugin marketplace list --json 2>/dev/null | jq -r '.[] | "\(.name)|\(.repo)"')
            set -l mp_name (echo $entry | cut -d'|' -f1)
            set -l mp_repo (echo $entry | cut -d'|' -f2)
            if not contains $mp_repo $desired_repos
                echo "Removing marketplace: $mp_name"
                claude plugin marketplace remove $mp_name 2>&1; or true
            end
        end
    end

    # Install plugins
    echo ''
    echo (set_color --bold blue)':: Installing Claude plugins'(set_color normal)
    for plugin in (grep -v '^#' ~/.claude/plugins.txt 2>/dev/null | grep -v '^$')
        claude plugin install $plugin 2>&1; or true
    end

    # Prune plugins not in config (user scope only)
    if test "$prune" = --prune
        echo ''
        echo (set_color --bold blue)':: Pruning unlisted plugins'(set_color normal)
        # Extract just plugin names from config (without @marketplace)
        set -l desired_plugins (grep -v '^#' ~/.claude/plugins.txt 2>/dev/null | grep -v '^$' | sed 's/@.*//')
        # Extract npx package names (remove -cc suffix and @version)
        set -l npx_plugins (grep -v '^#' ~/.claude/npx-packages.txt 2>/dev/null | grep -v '^$' | sed 's/@.*//' | sed 's/-cc$//')
        # Get installed user-scope plugins
        for installed in (claude plugin list --json 2>/dev/null | jq -r '.[] | select(.scope == "user") | .id' | sort -u)
            set -l plugin_name (echo $installed | sed 's/@.*//')
            # Skip if in desired list or installed via npx
            if not contains $plugin_name $desired_plugins
                if contains $plugin_name $npx_plugins
                    echo "Skipping npx plugin: $plugin_name"
                    continue
                end
                echo "Removing plugin: $plugin_name"
                claude plugin uninstall $plugin_name --scope user 2>&1; or true
            end
        end
    end

    echo ''
    echo (set_color --bold green)'Done!'(set_color normal)
end
