
GIT =git --git-dir=$(HOME)/.dotfiles/ --work-tree=$(HOME) 

config-update-submodules: .FORCE
	$(GIT) submodule update --remote

.FORCE:
