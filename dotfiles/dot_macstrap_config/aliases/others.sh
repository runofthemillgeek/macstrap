#!/usr/bin/env zsh

mkcd() {
    mkdir -p "$1" && cd "$1";
}

alias cat="bat"
alias ls="eza"
alias sa="source ~/.zshrc"
alias se="code ~/.zshrc"

alias work="cd ~/work"
alias dev="cd ~/dev"
