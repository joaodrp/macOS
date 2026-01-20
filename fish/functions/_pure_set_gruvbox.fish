function _pure_set_gruvbox --argument-names mode --description 'Set Pure prompt Gruvbox colors'
    if test "$mode" = dark
        # Base colors
        set --universal pure_color_primary 8ec07c      # aqua - directory
        set --universal pure_color_info 83a598         # blue
        set --universal pure_color_mute 928374         # gray
        set --universal pure_color_success b8bb26      # green
        set --universal pure_color_danger fb4934       # red
        set --universal pure_color_warning fabd2f      # yellow
        set --universal pure_color_dark 282828         # bg
        set --universal pure_color_light ebdbb2        # fg
        set --universal pure_color_normal normal
        # Git colors
        set --universal pure_color_git_branch 83a598   # blue
        set --universal pure_color_git_dirty d3869b    # purple
        set --universal pure_color_git_stash d3869b    # purple
        set --universal pure_color_git_unpulled_commits d3869b  # purple
        set --universal pure_color_git_unpushed_commits d3869b  # purple
        # Prompt colors
        set --universal pure_color_prompt_on_success b8bb26    # green
        set --universal pure_color_prompt_on_error fb4934      # red
        set --universal pure_color_command_duration fabd2f     # yellow
        set --universal pure_color_current_directory 8ec07c    # aqua
        set --universal pure_color_jobs d3869b                 # purple
        set --universal pure_color_virtualenv 83a598           # blue
        set --universal pure_color_system_time 928374          # gray
        set --universal pure_color_hostname 928374             # gray
        set --universal pure_color_username_normal ebdbb2      # fg
        set --universal pure_color_username_root fb4934        # red
    else
        # Base colors
        set --universal pure_color_primary 689d6a      # aqua - directory
        set --universal pure_color_info 458588         # blue
        set --universal pure_color_mute 928374         # gray
        set --universal pure_color_success 98971a      # green
        set --universal pure_color_danger cc241d       # red
        set --universal pure_color_warning d79921      # yellow
        set --universal pure_color_dark 3c3836         # fg
        set --universal pure_color_light fbf1c7        # bg
        set --universal pure_color_normal normal
        # Git colors
        set --universal pure_color_git_branch 458588   # blue
        set --universal pure_color_git_dirty b16286    # purple
        set --universal pure_color_git_stash b16286    # purple
        set --universal pure_color_git_unpulled_commits b16286  # purple
        set --universal pure_color_git_unpushed_commits b16286  # purple
        # Prompt colors
        set --universal pure_color_prompt_on_success 98971a    # green
        set --universal pure_color_prompt_on_error cc241d      # red
        set --universal pure_color_command_duration d79921     # yellow
        set --universal pure_color_current_directory 689d6a    # aqua
        set --universal pure_color_jobs b16286                 # purple
        set --universal pure_color_virtualenv 458588           # blue
        set --universal pure_color_system_time 928374          # gray
        set --universal pure_color_hostname 928374             # gray
        set --universal pure_color_username_normal 3c3836      # fg
        set --universal pure_color_username_root cc241d        # red
    end
end
