#!/bin/bash

configure_iterm2() {
    local profilesDir="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
    cp iterm2/iterm2-profile.json "$profilesDir/"
}
