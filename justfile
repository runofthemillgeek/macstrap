# https://just.systems

set positional-arguments
work := "false"

default:
    mise settings experimental=true
    mise install

lint:
    fd -H -t f '\.sh$|\..*rc' -E '**/*.zshrc' -x shellcheck --severity=error --shell=bash --external-sources --color=always

chez *ARGS:
    chezmoi -c chezmoi.toml --override-data='{ "workMode": {{work}} }' "$@"
