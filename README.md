<div align="center">

# macstrap

Sangeeth's simple and highly opinionated setup and scripts for a macOS installation.

</div>

---

For fresh setups, run:

```sh
# personal
./setup.sh

# work
./setup.sh -w
```

For re-runs:

```sh
# personal
./setup.sh -s

# work
./setup.sh -sw
```

## Uses

- chezmoi: for dotfile management
- bash scripts

## Development

If you have mise and just setup, simply run:

```sh
just
```

Otherwise:

1. Install mise from https://mise.jdx.dev
2. Git clone this repo
3. cd into this repo
4. Run the following

   ```sh
   mise settings experimental=true
   mise install
   ```
5. Run `just -l` from the project dir and make sure everything looks good.

Commands:

- Run `just lint` to run shellcheck
- Run `just work=true chez` for chezmoi testing

## References

- dotfiles/configs from others
  - https://github.com/mathiasbynens/dotfiles
- macOS
  - https://macos-defaults.com/
  - @mathiasbynens' [.macos file](https://github.com/mathiasbynens/dotfiles/blob/b7c7894e7bb2de5d60bfb9a2f5e46d01a61300ea/.macos)
  - https://mac-key-repeat.zaymon.dev/ — to figure out values for `InitialKeyRepeat` and `KeyRepeat` settings

---

TODO

- [x] Cursor config
- [x] Zed config
- [ ] ssh config
- [ ] Safari config
- [ ] Remaining macOS config
- [ ] Address TODO comments
