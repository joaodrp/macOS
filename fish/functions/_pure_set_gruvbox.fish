function _pure_set_gruvbox --argument-names mode --description 'Set Pure prompt Gruvbox colors'
    # Using official Gruvbox palette - neutral for normal, bright/faded for emphasis
    # Matches Ghostty/OpenCode terminal palette convention
    if test "$mode" = dark
        # Base colors (neutral)
        set --universal pure_color_primary 8ec07c      # aqua bright - directory (emphasis)
        set --universal pure_color_info 458588         # blue neutral
        set --universal pure_color_mute 928374         # gray
        set --universal pure_color_success 98971a      # green neutral
        set --universal pure_color_danger fb4934       # red bright (emphasis)
        set --universal pure_color_warning d79921      # yellow neutral
        set --universal pure_color_dark 1d2021         # bg (hard)
        set --universal pure_color_light ebdbb2        # fg
        set --universal pure_color_normal normal
        # Git colors (neutral)
        set --universal pure_color_git_branch 458588   # blue neutral
        set --universal pure_color_git_dirty b16286    # purple neutral
        set --universal pure_color_git_stash b16286    # purple neutral
        set --universal pure_color_git_unpulled_commits b16286  # purple neutral
        set --universal pure_color_git_unpushed_commits b16286  # purple neutral
        # Prompt colors
        set --universal pure_color_prompt_on_success b8bb26    # green bright (emphasis)
        set --universal pure_color_prompt_on_error fb4934      # red bright (emphasis)
        set --universal pure_color_command_duration d79921     # yellow neutral
        set --universal pure_color_current_directory 8ec07c    # aqua bright (emphasis)
        set --universal pure_color_jobs b16286                 # purple neutral
        set --universal pure_color_virtualenv 458588           # blue neutral
        set --universal pure_color_system_time 928374          # gray
        set --universal pure_color_hostname 928374             # gray
        set --universal pure_color_username_normal ebdbb2      # fg
        set --universal pure_color_username_root fb4934        # red bright (emphasis)
    else
        # Base colors (neutral)
        set --universal pure_color_primary 427b58      # aqua faded - directory (emphasis)
        set --universal pure_color_info 458588         # blue neutral
        set --universal pure_color_mute 928374         # gray
        set --universal pure_color_success 98971a      # green neutral
        set --universal pure_color_danger 9d0006       # red faded (emphasis)
        set --universal pure_color_warning d79921      # yellow neutral
        set --universal pure_color_dark 3c3836         # fg
        set --universal pure_color_light f9f5d7        # bg (hard)
        set --universal pure_color_normal normal
        # Git colors (neutral)
        set --universal pure_color_git_branch 458588   # blue neutral
        set --universal pure_color_git_dirty b16286    # purple neutral
        set --universal pure_color_git_stash b16286    # purple neutral
        set --universal pure_color_git_unpulled_commits b16286  # purple neutral
        set --universal pure_color_git_unpushed_commits b16286  # purple neutral
        # Prompt colors
        set --universal pure_color_prompt_on_success 79740e    # green faded (emphasis)
        set --universal pure_color_prompt_on_error 9d0006      # red faded (emphasis)
        set --universal pure_color_command_duration d79921     # yellow neutral
        set --universal pure_color_current_directory 427b58    # aqua faded (emphasis)
        set --universal pure_color_jobs b16286                 # purple neutral
        set --universal pure_color_virtualenv 458588           # blue neutral
        set --universal pure_color_system_time 928374          # gray
        set --universal pure_color_hostname 928374             # gray
        set --universal pure_color_username_normal 3c3836      # fg
        set --universal pure_color_username_root 9d0006        # red faded (emphasis)
    end
end
