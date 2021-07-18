function registry_env --argument server
  switch "$server"
  case registry.gitlab.com
    op_signin
    set -x CR_ADDR registry.gitlab.com
    set -x CR_USER ...
    set -x CR_ACCESS_TOKEN (set -x CR_PAT (op get item gitlab.com | jq -r '.details.sections[] | select(.title == "PAT").fields[] | select(.t == "registry.rw").v'))
  case '*'
    echo "Command input must be 'registry.gitlab.com'"
  end
end
