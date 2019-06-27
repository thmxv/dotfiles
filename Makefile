# TODO: install tagrgets that create links in $HOME

update: .FORCE
	git pull --rebase
	git submodule update --init --recursive
	git submodule foreach git checkout master
	git submodule foreach git pull --rebase origin master

.FORCE:
