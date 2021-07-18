function registry_env
    set -x CR_TOKEN (https -a $CR_USER:$CR_ACCESS_TOKEN gitlab.com/jwt/auth ... )  
end
