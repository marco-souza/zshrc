ALL: update apply

update: ~/.aliases ~/.zshrc
	cp {~,.}/.aliases
	cp {~,.}/.zshrc

apply: apply.sh
	sh apply.sh
