function sync_tmux_background -d "Sync tmuxline theme mode (light/dark)"
  switch (read_appearance_mode)
    case dark
      tmux source-file ~/.tmux/tmuxline-dark.conf
    case light
      tmux source-file ~/.tmux/tmuxline-light.conf
  end
end