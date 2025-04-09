if status is-interactive
    set -gx EDITOR nvim
    set -g fish_greeting
    # Setup vim key bindings
    set -g fish_key_bindings fish_vi_key_bindings
    set fish_cursor_insert line
    set fish_vi_force_cursor 1
    set -gx TERMINAL wezterm

    

    

    # Setup atuin 
    atuin init fish | source
    # Setup zoxide
    zoxide init fish | source

    # Setup keychain
    if status is-login
        keychain --eval --quiet ~/.ssh/id_ed25519 | source
    end

    # alias
    alias ls='eza --icons --hyperlink'

    alias l='eza --icons --hyperlink -l'
    alias ll='eza --icons --hyperlink -lh'
    alias la='eza --icons --hyperlink -la'
    alias lt='eza --icons --hyperlink -T'

    alias cat="bat"

    alias du="dust"
end

function fish_user_key_bindings
    # Set k in normal mode to atuin history opening
    bind -M default \k _atuin_search
end
