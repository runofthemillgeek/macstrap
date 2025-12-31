# https://just.systems

work := "false"

default:
    mise settings experimental=true
    mise install

lint:
    fd -H -t f '\.sh$|\..*rc' -E '**/*.zshrc' -x shellcheck -S error -x --color=always

chez +ARGS:
    chezmoi -c chezmoi.toml {{ARGS}} --override-data='{ "workMode": {{work}} }'
