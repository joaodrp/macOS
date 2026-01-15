# https://github.com/pure-fish/pure
# Customization (loads before pure.fish due to underscore prefix)
set -g pure_color_prompt_on_success yellow
set -g pure_color_current_directory green
set -g pure_color_git_branch brblack
set -g pure_color_git_dirty brblack
set -g pure_color_git_stash green
set -g pure_color_git_unpulled_commits green
set -g pure_color_git_unpushed_commits green
set -g pure_symbol_prompt '»'
set -g pure_show_jobs true
set -g pure_show_subsecond_command_duration true
set -g pure_threshold_command_duration 2
set -g pure_show_numbered_git_indicator true
set -g pure_enable_container_detection true
set -g pure_enable_k8s true
set -g pure_show_exit_status true
set -g pure_symbol_ssh_prefix 'ssh:'
set -g pure_show_prefix_root_prompt true
