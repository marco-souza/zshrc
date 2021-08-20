# My default zsh config

This repo generates and setup my default alias for `zsh`:

- Arch Linux
- Ubuntu
- OSX

## Dependencies

- python3 + pip
- node + npm
- zsh `>= 5.2`

## Usage

Just run

```sh
deno run --allow-read --allow-write --allow-env --unstable \
  https://raw.githubusercontent.com/marco-souza/zshrc/fea/zetup/zetup.ts -o out -s arch
```

Instal and run

```sh
# install
deno install --allow-read --allow-write --allow-env --unstable https://raw.githubusercontent.com/marco-souza/zshrc/fea/zetup/zetup.ts
# run
zetup -o out -s arch
```

**Note**: Generated files are in `zshrc/` folder.
