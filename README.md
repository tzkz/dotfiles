# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Contents

Dotfile packages live in `dotfiles/`.

## Requirements

- `stow`
- `git`

## Install

Clone the repo and run the stow script:

```sh
git clone <repo-url>
cd dotfiles
./stow.sh
```

This symlinks each package in `dotfiles/` into your home directory.

If Stow reports conflicts, move or back up the existing files first, then rerun `./stow.sh`.

