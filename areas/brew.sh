#!/usr/bin/env zsh

install_brew() {
	# Check if already installed?
	if which brew 2> /dev/null; then
		log "Brew already installed"
		return
	fi

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	touch "$HOME/.zprofile"
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
	eval "$(/opt/homebrew/bin/brew shellenv)"
}

brew_install_programs() {
	local common_programs=(
        act                             # For testing github actions
        bat                             # cat with syntax highlighting
        caddy
        container
        difftastic                      # Syntax-aware diffs
        dive                            # Inspect Docker image layers
        dnsmasq
        eza                             # ls with colors and better output
        fd                              # Friendlier version of find
        ffmpeg
        fzf
        gh                              # GitHub CLI
        iperf3
        kew                             # CLI music player
        mise
        mpv
        neovim
        pstree                          # ps output as a tree
        rclone
        ripgrep                         # Nicer and better grep
        spotify_player
        tmux
        uv                              # One tool to rule them all for Python projects & pkg management
        vim
        watchman
        yt-dlp
        zoxide                          # Remembers as you cd into dirs and allows you to jump to any using `z`
	)

    local work_programs=(
        withgraphite/tap/graphite       # `gt` CLI for graphite.dev
    )

	brew install "${common_programs[@]}"
}

brew_install_gui_apps() {
    local common_programs=(
        1password
        alt-tab
        firefox
        google-chrome
        gpg-suite
        iterm2
        jordanbaird-ice@beta
        karabiner-elements
        linearmouse
        orbstack
        raycast
        setapp
        zed
    )

    local personal_programs=(
        protonvpn
        signal
        steam
	)

    local work_programs=(
        antigravity
        blackhole-2ch
        cursor
        gather
        linear-linear
        notion
        slack
    )

	brew install --cask "${common_programs[@]}"

    if [[ "$work_mode" == true ]]; then
        brew install --cask "${work_programs[@]}"
    else
        brew install --cask "${personal_programs[@]}"
    fi
}
