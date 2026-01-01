#!/usr/bin/env zsh

GREEN="\033[32m"
RED="\033[31m"
RESET="\033[0m"

log_section_start() {
    printf "$GREEN==> %s\n\n$RESET" "$1"
}

log_section_end() {
    printf "$GREEN<== %s\n\n$RESET" "$1"
}

log() {
    printf "%s\n" "$1"
}

log_error() {
    printf "${RED}ERROR: %s\n$RESET" "$1" >&2
}
