function wifi_pass --description 'Get WiFi password from Keychain'
    if test (count $argv) -ne 1
        echo "usage: wifi_pass <network-name>"
        return 1
    end
    security find-generic-password -wa $argv[1]
end
