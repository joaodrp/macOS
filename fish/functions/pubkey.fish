function pubkey --description 'Copy SSH public key to clipboard'
    if test -f ~/.ssh/id_ed25519.pub
        cat ~/.ssh/id_ed25519.pub | pbcopy
        echo "=> Public key copied to clipboard"
    else if test -f ~/.ssh/id_rsa.pub
        cat ~/.ssh/id_rsa.pub | pbcopy
        echo "=> Public key copied to clipboard"
    else
        echo "No SSH public key found"
        return 1
    end
end
