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
fi

#
# Aliases
#

# Pacman.
alias pac='pacman'

# Installs packages from repositories.
alias paci='pacman -S'

# Installs packages from files.
alias pacI='pacman -U'

# Removes packages and unneeded dependencies.
alias pacx='pacman -R'

# Removes packages, their configuration, and unneeded dependencies.
alias pacX='pacman -Rns'

# Displays information about a package from the repositories.
alias pacq='pacman -Si'

# Displays information about a package from the local database.
alias pacQ='pacman -Qi'

# List the contents of the queried package
alias pacL='pacman -Ql'

# Query the package that owns <file>
alias pacO='pacman -Qo'

# Searches for packages in the repositories.
alias pacs='pacman -Ss'

# Searches for packages in the local database.
alias pacS='pacman -Qs'

# Lists orphan packages.
alias pacman-list-orphans='pacman -Qdt'

# Removes orphan packages.
alias pacman-remove-orphans='pacman -Rs $(pacman --quiet -Q --deps --unrequired)'

# Synchronizes the local package and Arch Build System databases against the
# repositories.
if (( $+commands[abs] )); then
  alias pacu='pacman -Sy && sudo abs'
else
  alias pacu='pacman -Sy'
fi

# Synchronizes the local package database against the repositories then
# upgrades outdated packages.
alias pacU='pacman -Syu'

unset _pacman_frontend

