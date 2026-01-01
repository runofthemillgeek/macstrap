#!/usr/bin/env zsh

macos_configure_beforeall() {
    # Close any open System Preferences panes, to prevent them from overriding
    # settings we’re about to change
    osascript -e 'tell application "System Preferences" to quit'
}

macos_configure_defaults() {
	# Turns off input for certain characters by pressing and holding keys.
	# I like the same key to go brrr when I press and hold.
	defaults write -g ApplePressAndHoldEnabled -bool false

	# Trackpad: Tap to click
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

    # Enable full keyboard access for all controls
    # (e.g. enable Tab in modal dialogs)
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

    # Disable Resume system-wide
    defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

    # Set a fast keyboard repeat rate
    defaults write -g InitialKeyRepeat -int 10
    defaults write -g KeyRepeat -int 2

    # Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
    defaults write com.apple.finder QuitMenuItem -bool true

    # Set $HOME as the default location for new Finder windows
    # For other paths, use `PfLo` and `file:///full/path/here/`
    defaults write com.apple.finder NewWindowTarget -string "PfHm"
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

    # Finder: show all filename extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # Finder: show status bar
    defaults write com.apple.finder ShowStatusBar -bool true

    # Finder: show path bar
    defaults write com.apple.finder ShowPathbar -bool true

    # When performing a search, search the current folder by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # Disable the warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    # Use list view in all Finder windows by default
    # Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

    # FIXME: Might affect existing chezmoi config, so need to check before uncommenting
    # Show the ~/Library folder
    # chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

    # Show the /Volumes folder
    # sudo chflags nohidden /Volumes

    # Expand the following File Info panes:
    # “General”, “Open with”, and “Sharing & Permissions”
    defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

    killall cfprefsd
	killall Dock
	killall SystemUIServer
	killall Finder
}

macos_configure_spotlight() {
    # TODO: Implement for latest macOS version
    log "Not implemented"
}

macos_configure_dock() {
   	# Dock: autohide
	defaults write com.apple.dock autohide -bool true

    # Dock: Make Dock icons of hidden applications translucent
    defaults write com.apple.dock showhidden -bool true

    # Dock: Don’t show recent applications in Dock
    defaults write com.apple.dock show-recents -bool false

     if [[ "$work_mode" == "false" ]]; then
         log "Dock icons config not written for personal only mode"
         return
     fi

    local apps=(
        "/System/Applications/Apps.app"
        "/System/Applications/Mail.app"
        "/Applications/Google Chrome.app"
        "/Applications/Cursor.app"
        "/Applications/Zed.app"
        "/Applications/Linear.app"
        "/Applications/Slack.app"
        "/Applications/Gather.app"
        "/System/Applications/System Settings.app"
    )

    if [[ "$work_mode" == "true" ]]; then
        apps[2]="/Applications/Setapp/Spark Mail.app"
    fi

    log "Resetting Dock"
    dockutil --remove all --no-restart

    for (( i=1; i<=${#apps}; i++ )); do
        local app_path="${apps[$i]}"

        log "Adding $app_path at position $i"
        dockutil --add "$app_path" --position "$i" --no-restart > /dev/null
    done

    log "Restarting Dock"
    killall Dock
}
