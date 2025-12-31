#!/bin/sh

macstrap_dir=~/.macstrap

export LANG=en_US.UTF-8
export EDITOR='nvim'

export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"

export plugins=(
  fzf
  fzf-tab
  git
  zsh-autosuggestions
  zoxide
)

# IMPORTANT: This is probably one side-effect I'm keeping here cause
# ordering matters! Remove existing `source` in `.zshrc`
source $ZSH/oh-my-zsh.sh

export PAGER='less -FRX'

# Fix when installing ruby with asdf/mise and brew
# Might also need to run:
# $ brew install readline libyaml
export CPATH=$(brew --prefix)/include
export LIBRARY_PATH=$(brew --prefix)/lib

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# https://github.com/zsh-users/zsh-autosuggestions/issues/351
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)
export ZSH_AUTOSUGGEST_CLEAR_WIDGETS

export PATH="$HOME/go/bin:$HOME/.local/bin:$PATH"

eval "$(mise activate zsh)"
eval "$(uv generate-shell-completion zsh)"

source $macstrap_dir/aliases/git.sh
source $macstrap_dir/aliases/others.sh
