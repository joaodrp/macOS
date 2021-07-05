function bat_theme --argument theme
  if ! test -f ~/.config/bat/config
    echo "file ~/.config/bat/config doesn't exist"
    return
  end

  # sed doesn't like symlinks, get the absolute path
  set -l config_path (realpath ~/.config/bat/config)
  sed -i -e "s#^--theme='.*'#--theme='$theme'#g" $config_path
  echo "switched to $theme"
end
