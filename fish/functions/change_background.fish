function change_background --argument mode_setting
  # change background to the given mode. If mode is missing,
  # we try to deduct it from the system settings.

  set -l mode "light" # default value
  if test -z $mode_setting
    set -l val (defaults read -g AppleInterfaceStyle > /dev/null 2>&1)
    if test $status -eq 0
      set mode "dark"
    end
  else
    switch $mode_setting
      case light
        osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false" >/dev/null
        set mode "light"
      case dark
        osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true" >/dev/null
        set mode "dark"
    end
  end

  # well, seems like there is no proper way to send a command to
  # Vim as a client. Luckily we're using tmux, which means we can
  # iterate over all vim sessions and change the background ourself.
  set -l tmux_wins (/usr/local/bin/tmux list-windows -t main)

  for wix in (/usr/local/bin/tmux list-windows -t main -F 'main:#{window_index}')
    for pix in (/usr/local/bin/tmux list-panes -F 'main:#{window_index}.#{pane_index}' -t $wix)
      set -l is_vim "ps -o state= -o comm= -t '#{pane_tty}'  | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?\$'"
      /usr/local/bin/tmux if-shell -t "$pix" "$is_vim" "send-keys -t $pix escape ENTER"
      /usr/local/bin/tmux if-shell -t "$pix" "$is_vim" "send-keys -t $pix ':call ChangeBackground()' ENTER"
    end
  end

  # change tmux
  switch $mode
    case dark
      tmux source-file ~/.tmux/tmuxline-dark.conf
    case light
      tmux source-file ~/.tmux/tmuxline-light.conf
  end

  # change alacritty
  switch $mode
    case dark
      alacritty_theme gruvbox_dark
    case light
      alacritty_theme gruvbox_light
  end

  # change alacritty
  switch $mode
    case dark
      alacritty_theme gruvbox-dark
    case light
      alacritty_theme gruvbox-light
  end

  # change mitmproxy
  switch $mode
    case dark
      mitmproxy_theme solarized_dark
    case light
      mitmproxy_theme solarized_light
  end

  # change fzf
  switch $mode
    case dark
      set -l color00 '#1d2021'
      set -l color01 '#3c3836'
      set -l color02 '#504945'
      set -l color03 '#665c54'
      set -l color04 '#bdae93'
      set -l color05 '#d5c4a1'
      set -l color06 '#ebdbb2'
      set -l color07 '#fbf1c7'
      set -l color08 '#fb4934'
      set -l color09 '#fe8019'
      set -l color0A '#fabd2f'
      set -l color0B '#b8bb26'
      set -l color0C '#8ec07c'
      set -l color0D '#83a598'
      set -l color0E '#d3869b'
      set -l color0F '#d65d0e'
    case light
      set -l color00 '#f9f5d7'
      set -l color01 '#ebdbb2'
      set -l color02 '#d5c4a1'
      set -l color03 '#bdae93'
      set -l color04 '#665c54'
      set -l color05 '#504945'
      set -l color06 '#3c3836'
      set -l color07 '#282828'
      set -l color08 '#9d0006'
      set -l color09 '#af3a03'
      set -l color0A '#b57614'
      set -l color0B '#79740e'
      set -l color0C '#427b58'
      set -l color0D '#076678'
      set -l color0E '#8f3f71'
      set -l color0F '#d65d0e'
  end
  set -l FZF_NON_COLOR_OPTS

  for arg in (echo $FZF_DEFAULT_OPTS | tr " " "\n")
    if not string match -q -- "--color*" $arg
      set -a FZF_NON_COLOR_OPTS $arg
    end
  end

  set -U FZF_DEFAULT_OPTS "$FZF_NON_COLOR_OPTS"\
  " --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D"\
  " --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
  " --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
end
