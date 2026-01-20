# Gruvbox Light fzf theme
# Source: https://github.com/morhetz/gruvbox
# Using official Gruvbox palette - neutral for normal, faded for emphasis

set -l FZF_NON_COLOR_OPTS

for arg in (echo $FZF_DEFAULT_OPTS | tr " " "\n")
    if not string match -q -- "--color*" $arg
        set -a FZF_NON_COLOR_OPTS $arg
    end
end

set -Ux FZF_DEFAULT_OPTS "$FZF_NON_COLOR_OPTS"\
" --color=fg:#3c3836,bg:#fbf1c7,hl:#b57614"\
" --color=fg+:#3c3836,bg+:#ebdbb2,hl+:#b57614"\
" --color=info:#458588,prompt:#98971a,pointer:#9d0006"\
" --color=marker:#9d0006,spinner:#689d6a,header:#458588"\
" --color=border:#d5c4a1,gutter:#fbf1c7"
