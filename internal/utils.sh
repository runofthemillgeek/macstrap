#!/bin/bash

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
