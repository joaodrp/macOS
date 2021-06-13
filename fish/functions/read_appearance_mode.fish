function read_appearance_mode -d "Read OS appearance mode (light/dark)"
  set -l val (defaults read -g AppleInterfaceStyle > /dev/null 2>&1)
  if test $status -eq 0
    echo "dark"
  else
    echo "light"
  end
end