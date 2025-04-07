if status is-interactive
    set -gx EDITOR nvim
    set -g fish_greeting
    # Setup vim key bindings
    set -g fish_key_bindings fish_vi_key_bindings
    set fish_cursor_insert line
    set fish_vi_force_cursor 1
    set -gx TERMINAL wezterm

    # bun
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH="$HOME/.local/bin:$PATH"
    export PATH="$HOME/go/bin:$PATH"
    export PATH="$PATH:/home/vdlugosch-zalf/.dotnet/tools"
    export PATH="$PATH:/home/vdlugosch-zalf/zalf-rpm/mas_csharp/lib/capnproto-dotnetcore/capnpc-csharp/bin/Release/net9.0"
    export PATH="$PATH:/home/vdlugosch-zalf/minio-binaries"

    # Setup atuin 
    atuin init fish | source

    # Setup zoxide
    zoxide init fish | source

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
