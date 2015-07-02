#
# Defines Pacman aliases.
#
# Authors:
#   Benjamin Boudreau <dreurmail@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
# Tips:
#   https://wiki.archlinux.org/index.php/Pacman_Tips
#

# Return if requirements are not found.
if (( ! $+commands[pacman] )); then
  return 1
fi

#
# Frontend
#

# Get the Pacman frontend.
zstyle -s ':prezto:module:pacman' frontend '_pacman_frontend'

if (( $+commands[$_pacman_frontend] )); then
  alias pacman="$_pacman_frontend"

  if [[ -s "${0:h}/${_pacman_frontend}.zsh" ]]; then
    source "${0:h}/${_pacman_frontend}.zsh"
  fi
else
  _pacman_frontend='pacman'
  _pacman_sudo='sudo '
fi

#
# Aliases
#

# Pacman.
alias pac="${_pacman_frontend}"

# Installs packages from repositories.
alias paci="${_pacman_sudo}${_pacman_frontend} -S"

# Installs packages from files.
alias pacI="${_pacman_sudo}${_pacman_frontend} -U"

# Removes packages and unneeded dependencies.
alias pacx="${_pacman_sudo}${_pacman_frontend} -R"

# Removes packages, their configuration, and unneeded dependencies.
alias pacX="${_pacman_sudo}${_pacman_frontend} -R --nosave --recursive"

# Displays information about a package from the repositories.
alias pacq="${_pacman_frontend} -S --info"

# Displays information about a package from the local database.
alias pacQ="${_pacman_frontend} -Q --info"

# List the contents of the queried package
alias pacL="${_pacman_frontend} -Q -l"

# Query the package that owns <file>
alias pacO="${_pacman_frontend} -Q -o"

# Searches for packages in the repositories.
alias pacs="${_pacman_frontend} -S --search"

# Searches for packages in the local database.
alias pacS="${_pacman_frontend} -Q --search"

# Lists orphan packages.
alias pacman-list-orphans="${_pacman_sudo}${_pacman_frontend} -Q --deps --unrequired"

# Removes orphan packages.
alias pacman-remove-orphans="${_pacman_sudo}${_pacman_frontend} -R --recursive \$(${_pacman_frontend} --quiet -Q --deps --unrequired)"

# Synchronizes the local package and Arch Build System databases against the
# repositories.
if (( $+commands[abs] )); then
  alias pacu="${_pacman_sudo}${_pacman_frontend} -S --refresh && sudo abs"
else
  alias pacu="${_pacman_sudo}${_pacman_frontend} -S --refresh"
fi

# Synchronizes the local package database against the repositories then
# upgrades outdated packages.
alias pacU="${_pacman_sudo}${_pacman_frontend} -S --refresh --sysupgrade"

unset _pacman_{frontend,sudo}
