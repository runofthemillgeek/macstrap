#!/usr/bin/env zsh

ask() {
    read "answer?${1}: "
    if [[ -z "$answer" ]]; then
        log_error "Answer cannot be empty"
        return 1
    fi
    echo "$answer"
}

xchez() {
    chezmoi -c chezmoi.toml \
        --override-data="{\"workMode\": $work_mode}" \
        $*
}

sudo_keepalive() {
    # Ask for the administrator password upfront
    sudo -v

    # Keep-alive: update existing `sudo` time stamp until `.macos` has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}
