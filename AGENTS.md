# Repository Instructions

## Repository Context

- This is the live `~/.zprezto` configuration, not a package to build. The
  `runcoms/*` files are symlinked into `$HOME`, so edits affect the next shell.
- Work on `custom`, the default fork branch. `master` tracks upstream Prezto;
  keep changes to upstream files minimal so future merges remain tractable.
- External plugins under `modules/*/external` are nested Git submodules. Do not
  edit their contents as if they were ordinary files in this repository.

## Verification

- There is no root build, test suite, linter, or CI workflow. Syntax-check
  changed Zsh files with `zsh -n path/to/file`.
- Smoke-test startup with `zsh -i -c exit`. Without a TTY this currently emits
  expected `stty` and Starship `zle` warnings, so inspect new output rather than
  requiring silence.
- Reload the current interactive shell with `resource` (an alias for sourcing
  `~/.zshrc`). Profile startup with `PROFILE_STARTUP=true zsh -i -c exit`; xtrace
  goes to `~/.startlog.$$` and `zprof` reports at login.
- Test risky startup changes in an isolated `$ZDOTDIR`; follow the procedure in
  `CONTRIBUTING.md` rather than experimenting against the live configuration.
- Do not use upstream's `zprezto-update` on `custom`; it refuses non-`master`
  branches. Use `zupdate`, which rebases this repository and `contrib/`.

## Startup Wiring

- `runcoms/zshenv` runs for every Zsh. It also sources `.zprofile` for a
  top-level non-login, non-interactive shell, so changes there can affect scripts.
- `runcoms/zprofile` owns PATH construction and tool environment variables, then
  sources `~/.zprofile.local`.
- `runcoms/zshrc` sources `init.zsh`, defines aliases/helpers and completion
  caching, then sources `~/.zshrc.local`. Machine-specific overrides belong in
  those untracked `*.local` files.
- `init.zsh` sources `~/.zpreztorc` and loads its `pmodule` list in order. A new
  module directory is inert until added to that list.

## Modules And Prompt

- `pmodload` searches `modules/`, the gitignored separate `contrib/` repository,
  and configured `pmodule-dirs`. It autoloads eligible files from `functions/`,
  then sources `init.zsh` or `<module>.plugin.zsh`.
- New modules require `init.zsh` and `README.md`. Put argument-taking or large
  functions in `functions/`; underscore-prefixed files are completions.
- `is-callable`, `is-darwin`, `is-linux`, and `coalesce` come from the `helper`
  module. A module using them must first `pmodload 'helper'`; otherwise use a
  guard such as `(( $+commands[tool] ))`.
- Starship is the active prompt via `modules/starship/init.zsh`. The configured
  `aelesbao` Prezto theme is dormant because `prompt` is not in `pmodule`.

## Completion And Agent Gotchas

- `modules/rust/init.zsh` sets the cached `site_functions_path` and appends it to
  `$fpath`; keep `rust` loaded before the body of `runcoms/zshrc` uses that path.
- Add slow generated completions to `compl_commands` in `runcoms/zshrc`, then run
  `cache-completions true` in an interactive shell to force regeneration.
- `modules/gpg/init.zsh` derives GPG paths with `gpgconf`. With
  `enable-ssh-support`, it points `SSH_AUTH_SOCK` at gpg-agent, loads `ssh`, and
  runs `gpg-connect-agent UPDATESTARTUPTTY` before every command. That hook can
  stall while smartcard access is busy; use a guarded function override in
  `~/.zshrc.local` for machine-specific mitigation rather than changing shared
  behavior accidentally.

## Conventions

- Follow `CONTRIBUTING.md`: Google Shell style where applicable, 2-space indent,
  `local` variables, `zstyle` for configuration, `(( ... ))` for arithmetic, and
  the `function` keyword. `.editorconfig` requires LF and trimmed whitespace.
- Commits use Conventional Commits with optional scopes and `!` for breaking
  changes, as shown by the history. Keep commits atomic.
