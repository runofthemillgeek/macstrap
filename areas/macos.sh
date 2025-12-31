#!/bin/bash

configure_macos_defaults() {
	# Turns off input for certain characters by pressing and holding keys.
	# I like the same key to go brrr when I press and hold.
	defaults write -g ApplePressAndHoldEnabled -bool false
}
