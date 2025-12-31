set -euo pipefail

ask() {
    read "answer?${1}: "
    if [[ -z "$answer" ]]; then
        log_error "Answer cannot be empty"
        return 1
    fi
    echo "$answer"
}