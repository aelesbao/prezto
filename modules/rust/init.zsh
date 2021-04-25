#
# Configure Rust completions
#
# Authors:
#   Augusto Elesbão <https://github.com/aelesbao>
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

export RUSTUP_HOME="${RUSTUP_HOME:-${HOME}/.rustup}"
export CARGO_HOME="${CARGO_HOME:-${HOME}/.cargo}"

# Add Cargo binaries to path
if [[ -d "${CARGO_HOME}" ]]; then
  path+=("${CARGO_HOME}/bin")
fi

#
# Completions
#
site_functions_path="${XDG_CACHE_HOME:-$HOME/.cache}/prezto/site-functions"
fpath+=($site_functions_path)

typeset -A compl_commands=(
  rustup  'rustup completions zsh'
  cargo   'rustup completions zsh cargo'
)

for compl_command in "${(k)compl_commands[@]}"; do
  if (( $+commands[$compl_command] )); then
    function_file="$site_functions_path/_$compl_command"

    # Completion commands are slow; cache their output if old or missing.
    if [[ "$commands[$compl_command]" -nt "$function_file" \
          || "${ZDOTDIR:-$HOME}/.zpreztorc" -nt "$function_file" \
          || ! -s "$function_file" ]]; then
      mkdir -p "$function_file:h"
      command ${=compl_commands[$compl_command]} >! "$function_file" 2> /dev/null
    fi

    unset function_file
  fi
done

unset compl_command{s,}
