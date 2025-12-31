.PHONY: configure lint

configure:
	mise settings experimental=true
	mise install

lint:
	fd -H -t f '\.sh$$|\..*rc' -E '*/*.zshrc' -x shellcheck -S error -x --color=always
