# Gruvbox Dark fzf theme
# Source: https://github.com/morhetz/gruvbox
# Using official Gruvbox palette - neutral for normal, bright for emphasis

set -l FZF_NON_COLOR_OPTS

for arg in (echo $FZF_DEFAULT_OPTS | tr " " "\n")
    if not string match -q -- "--color*" $arg
        set -a FZF_NON_COLOR_OPTS $arg
    end
end

set -Ux FZF_DEFAULT_OPTS "$FZF_NON_COLOR_OPTS"\
" --color=fg:#ebdbb2,bg:#1d2021,hl:#fabd2f"\
" --color=fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f"\
" --color=info:#458588,prompt:#98971a,pointer:#fb4934"\
" --color=marker:#fb4934,spinner:#689d6a,header:#458588"\
" --color=border:#504945,gutter:#1d2021"
