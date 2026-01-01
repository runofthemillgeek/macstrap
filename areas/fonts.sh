#!/usr/bin/env zsh

install_fonts() {
    local mono_fonts=(
        annotation-mono
        departure-mono
        google-sans-code
        hack
        jetbrains-mono
    )

    local nerd_fonts=(
        hack-nerd-font
    )

    brew install --cask "${mono_fonts[@]/#/font-}"
    brew install --cask "${nerd_fonts[@]/#/font-}"
}
