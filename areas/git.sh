configure_git() {
    set -x
	git config --global user.name "Sangeeth Sudheer"
	git config --global user.email "git@sangeeth.dev"
	git config --global user.signingkey "F6D06ECE734C57D1"
	git config --global commit.gpgsign true
	git config --global pull.rebase true
	git config --global rebase.autoStash true
	git config --global rebase.autoSquash true
	git config --global push.autoSetupRemote true
	git config --global rerere.enabled true
    set +x
}