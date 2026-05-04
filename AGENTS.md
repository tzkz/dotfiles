# AGENTS.md

Guidance for coding agents working in this dotfiles repository.

## Repository overview

- This repo contains personal dotfiles managed by GNU Stow.
- Stow packages live under `dotfiles/`.
- Each package mirrors the target `$HOME` layout, for example:
  - `dotfiles/nvim/.config/nvim/` -> `~/.config/nvim/`
  - `dotfiles/tmux/.tmux.conf` -> `~/.tmux.conf`
  - `dotfiles/git/.gitconfig` -> `~/.gitconfig`

## Working guidelines

- Keep changes focused and avoid touching unrelated files.
- Preserve the existing style of each config file.
- Do not rewrite generated lockfiles unless the corresponding tool actually changed them.
- Be careful with files outside this repo; prefer editing only tracked dotfiles here.
- If unrelated local changes exist, leave them unstaged and unchanged.

## Neovim

- Neovim config is in `dotfiles/nvim/.config/nvim/`.
- Plugin specs live in `dotfiles/nvim/.config/nvim/lua/plugins/`.
- Prefer one focused plugin file per feature area, for example `completion.lua`, `lsp.lua`, or `telescope.lua`.
- `lazy.nvim` imports all plugin specs with `{ import = 'plugins' }`.
- After changing Lua files, syntax-check them when possible, for example:

```sh
luajit -e "assert(loadfile('dotfiles/nvim/.config/nvim/lua/plugins/<file>.lua'))"
```

- Run `:Lazy sync` in Neovim when plugin specs change and commit `lazy-lock.json` only if it was intentionally updated.

## Stow

- Use `./stow.sh` to symlink all packages into `$HOME`.
- Do not add machine-specific generated files unless they are intentionally part of the dotfiles.

## Commit messages

- Use the existing scope-prefix style when appropriate:
  - `nvim: ...`
  - `tmux: ...`
  - `git: ...`
- Keep commit messages concise and imperative.
