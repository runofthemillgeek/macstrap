#!/usr/bin/env zsh

function cursor_save_extensions() {
    cat ~/.cursor/extensions/extensions.json | jq -r '.[].identifier.id' > ./others/cursor-extensions.txt
}

function cursor_sync_extensions() {
    local currently_installed=$(cursor --list-extensions)

    cat ./others/cursor-extensions.txt | while IFS='\n' read extension
    do
        # We use grep -Fqx to ensure an exact line match
        if ! echo "$currently_installed" | grep -Fqx "$extension"; then
            log "Installing Cursor extension: $extension"
            # Install in background
            cursor --install-extension "$extension"
        else
            echo "$extension already installed on Cursor"
        fi
    done
}
