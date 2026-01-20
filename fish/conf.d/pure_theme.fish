# Pure prompt configuration

# Options
set --universal pure_show_numbered_git_indicator true
set --universal pure_show_jobs true
set --universal pure_enable_k8s false
set --universal pure_symbol_ssh_prefix "@ "
set --universal pure_show_system_time true
set --universal pure_show_subsecond_command_duration true
set --universal pure_reverse_prompt_symbol_in_vimode true
set --universal pure_show_prefix_root_prompt true

# Set colors based on current appearance
if test "$MACOS_APPEARANCE" = dark
    _pure_set_gruvbox dark
else
    _pure_set_gruvbox light
end
