# TODO: install tagrgets that create links in $HOME

update: .FORCE
	config pull --rebase
	config submodule update --init --recursive
	config submodule foreach git checkout master
	config submodule foreach git pull --rebase origin master

.FORCE:
