<div align="center">

# macstrap
_macOS + bootstrap_

A highly opinionated project to bootstrap a macOS machine and keep it up-to-date.

</div>

---

## Macstrappin'

### Step 1: Automated Install and Config

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

# dotfiles only
./setup.sh -d
```

### Step 2: Manual configs

#### Manual Authentications

**GUI apps:**

1. 1Password
2. Everything else.

**CLI apps:**

1. `gh`
2. `gt`

#### iTerm 2

1. Open Settings
2. Go to Profiles tab
3. Select the dynamic profile -> click "Other actions" -> Click "Set as default"
4. Quit and open iTerm2

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

To pull configs/settings from current machine, run `just work=[true|false] machine-pull`. **Make
sure to commit before doing so!**

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
- [ ] Look into converting to run with `bun shell`
