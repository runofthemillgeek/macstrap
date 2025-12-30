#!/usr/bin/env zsh

set -euo pipefail

echo "> Booting up macstrap"

# TODO: Get hostname
# TODO: Setup macOS defaults

install_brew() {
	# Check if already installed?
	if which brew 2> /dev/null; then
		echo "     # Brew already installed"
		return
	fi

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	touch "$HOME/.zprofile"
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
	eval "$(/opt/homebrew/bin/brew shellenv)"
}


brew_install_programs() {
	brew install eza \
		fd \
		ffmpeg \
		fzf \
		gh \
		kew \
		mise \
		neovim \
		ripgrep \
		yt-dlp \
		zoxide
}

brew_install_gui_apps() {
	brew install --cask 1password \
		firefox \
		google-chrome \
		iterm2 \
		karabiner-elements \
		protonvpn \
		raycast \
		setapp \
		signal \
		zed \
		gpg-suite
}

configure_git() {
	git config --global user.name "Sangeeth Sudheer"
	git config --global user.email "git@sangeeth.dev"
	git config --global user.signingkey "F6D06ECE734C57D1"
	git config --global commit.gpgsign true
	git config --global pull.rebase true
	git config --global rebase.autoStash true
	git config --global rebase.autoSquash true
	git config --global push.autoSetupRemote true
	git config --global rerere.enabled true
}

configure_macos_defaults() {
	# Turns off input for certain characters by pressing and holding keys.
	# I like the same key to go brrr when I press and hold.
	defaults write -g ApplePressAndHoldEnabled -bool false
}

install_oh_my_zsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

echo "> Configure macOS defaults"
configure_macos_defaults
echo "  -- Configuration complete"

echo "> Setting up oh-my-zsh"
echo " -- Installing oh-my-zsh"
install_oh_my_zsh
echo " -- Installation complete"

echo "> Setting up homebrew"
echo "	-- Installing homebrew"
install_brew
echo "	-- Installation complete"
echo "	-- Installing brew CLI programs"
brew_install_programs
echo "	-- Finished installing brew programs"
echo "	-- Installing brew GUI apps (casks)"
brew_install_gui_apps
echo "	-- Finished installing brew GUI apps"
echo "	-- Homebrew setup complete"

echo "> Setting up git"
echo "	-- Configuring git"
configure_git
echo "  -- Git configured"

echo "> Copying to ~/.macstrap"
rsync -avhP --exclude=".git" . ~/.macstrap
echo "	-- Copy completed"

echo "> Done. Ready to get shit done."
