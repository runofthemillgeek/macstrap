#!/bin/bash

mise_install_tools() {
    local tools=(
        bun
        deno
        go
        java
        node@lts
        python
        ruby
        zig
    )

    set -x
    mise use -g "${tools[@]}"
    set +x
}

install_rust() {
    # https://rust-lang.org/learn/get-started/
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
}
