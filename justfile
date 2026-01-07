# https://just.systems

set positional-arguments
work := "false"

default:
    mise settings experimental=true
    mise install

lint:
    fd -H -t f '\.sh$|\..*rc' -E '**/*.zshrc' -x shellcheck --severity=error --shell=bash --external-sources --color=always

machine-pull:
    chezmoi -c chezmoi.toml --override-data='{ "workMode": {{work}} }' re-add
    source areas/cursor.sh && cursor_save_extensions

chez *ARGS:
    chezmoi -c chezmoi.toml --override-data='{ "workMode": {{work}} }' "$@"
