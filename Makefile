ALL: update apply

update:
	git pull

apply: apply.sh
	sh apply.sh
