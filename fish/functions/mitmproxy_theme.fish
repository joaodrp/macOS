function mitmproxy_theme --argument theme
  if ! test -f ~/.mitmproxy/config.yaml
    echo "file ~/.mitmproxy/config.yaml doesn't exist"
    return
  end

  # sed doesn't like symlinks, get the absolute path
  set -l config_path (realpath ~/.mitmproxy/config.yaml)
  sed -i -e "s#^console_palette: .*#console_palette: $theme#g" $config_path
  echo "switched to $theme"
end
