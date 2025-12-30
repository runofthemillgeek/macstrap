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
	local programs=(
        act             # For testing github actions
        bat             # cat with syntax highlighting
        caddy
        container
        difftastic      # Syntax-aware diffs
        dive            # Inspect Docker image layers
        dnsmasq
        eza             # ls with colors and better output
        fd              # Friendlier version of find
        ffmpeg
        fzf
        gh              # GitHub CLI
        iperf3
        kew             # CLI music player
        mise
        mpv
        neovim
        pstree          # ps output as a tree
        rclone
        ripgrep         # Nicer and better grep
        spotify_player
        tmux
        uv              # One tool to rule them all for Python projects & pkg management
        vim
        watchman
        withgraphite/tap/graphite        # `gt` CLI for graphite.dev
        yt-dlp
        zoxide          # Remembers as you cd into dirs and allows you to jump to any using `z`
	)

	brew install "${programs[@]}"
}

brew_install_gui_apps() {
    local programs=(
        1password
        alt-tab
        firefox
        google-chrome
        gpg-suite
        iterm2
        jordanbaird-ice
        karabiner-elements
        linearmouse
        protonvpn
        raycast
        setapp
        signal
        zed
    )

	brew install --cask "${programs[@]}"
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
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" "--unattended" || true
}

install_omz_plugins() {
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || true
    git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab || true
}

install_powerlevel10k() {
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" || true
    cp zsh/.p10k.zsh "$HOME/"
}

configure_zsh() {
    touch ~/.hushlogin
    cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
    cp zsh/.zshrc "$HOME/"
}

install_fonts() {
    local hack_zip_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip"
    local fonts_dir="$HOME/Library/Fonts"
    mkdir -p "$fonts_dir/HackNF"
    curl -fsSL "$hack_zip_url" | bsdtar -xf - -C "$fonts_dir/HackNF"
}

configure_iterm2() {
    local profilesDir="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
    cp iterm2/iterm2-profile.json "$profilesDir/"
}

echo "> Configure macOS defaults"
configure_macos_defaults
echo "  -- Configuration complete"

echo "> Setting up git"
echo "  -- Configuring git"
configure_git
echo "  -- Git configured"

echo "> Setting up shell (zsh)"
echo " -- Installing oh-my-zsh (+p10k)"
install_oh_my_zsh
echo " -- Installing oh-my-zsh plugins"
install_omz_plugins
echo " -- Installing powerlevel10k"
install_powerlevel10k
echo " -- Configuring zsh"
configure_zsh
echo " -- Installation complete"

echo "> Setting up homebrew"
echo " -- Installing homebrew"
install_brew
echo "  -- Installation complete"
echo "  -- Installing brew CLI programs"
brew_install_programs
echo "  -- Finished installing brew programs"
echo "  -- Installing brew GUI apps (casks)"
brew_install_gui_apps
echo "  -- Finished installing brew GUI apps"
echo "  -- Homebrew setup complete"

echo "> Configuring iTerm2"
configure_iterm2
echo " -- iTerm2 configuration complete"

echo "> Copying to ~/.macstrap"
rsync -avhP --exclude=".git" . ~/.macstrap
echo "  -- Copy completed"

echo "> Downloading and installing fonts"
install_fonts
echo " -- Fonts installed"

echo "> Done. Ready to get shit done."

exec zsh -l
