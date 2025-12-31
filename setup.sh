#!/usr/bin/env bash

set -euo pipefail

source internal/log.sh
source internal/utils.sh

source areas/brew.sh
source areas/shell.sh
source areas/fonts.sh
source areas/macos.sh
source areas/devtools.sh

usage() {
    echo "Usage: $0 [-w]"
    echo "  -w: Install and configure for work in addition to personal use"
    echo "  -s: Skip prompts"
    echo "  -h: Show this help message"
    exit 1
}

work_mode=false
skip_prompts=false
mac_hostname=""

while getopts "ws" opt; do
    case $opt in
        w) work_mode=true ;;
        s) skip_prompts=true ;;
        h) usage ;;
        *) usage ;;
    esac
done

log "Starting macstrap"

if [[ "$skip_prompts" == false ]]; then
    mac_hostname=$(ask "Enter mac hostname") || exit 1

    log "Hostname will be set to: $mac_hostname"

    if [[ "$(ask "Proceed? (y/n)")" != "y" ]]; then
        log "Exiting"
        exit 1
    fi
else
    log "Skipping prompts"
fi

[[ "$work_mode" == true ]] && log "Work mode enabled"

###

log_section_start "Configure macOS"
configure_macos_defaults
log_section_end "macOS configured"

###

log_section_start "Setting up shell (zsh)"

log "Installing oh-my-zsh (+p10k)"
install_oh_my_zsh
log "oh-my-zsh installed"

log "Installing oh-my-zsh plugins"
install_omz_plugins
log "oh-my-zsh plugins installed"

log "Installing powerlevel10k"
install_powerlevel10k
log "powerlevel10k installed"

log_section_end "zsh setup complete"

###

log_section_start "Setting up homebrew + programs"

log "Installing homebrew"
install_brew
log "brew installed"

log "Installing brew CLI programs"
brew_install_programs
log "brew programs installed"

log "Installing brew GUI apps (casks)"
brew_install_gui_apps
log "brew GUI apps installed"

log_section_end "brew setup complete"

###

log_section_start "Installing and configuring devtools"

log "Installing mise tools"
mise_install_tools
log "Mise tools installed"

log "Installing Rust (rustup + cargo)"
install_rust
log "Rust tooling installed"

log_section_end "devtools installed"

###

log_section_start "Downloading and installing fonts"
install_fonts
log_section_end "Fonts installed"

###

log_section_start "Applying dotfiles and config files using chezmoi"
xchez apply
log_section_end "chezmoi apply complete"

###

log "Done. Ready to get shit done."

exec zsh -l
