#
# Ansible aliases and helpers.
#
# Authors:
#   Augusto Elesbão <aelesbao@users.noreply.github.com>
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]] || ! is-callable ansible; then
  return 1
fi

# Aliases
alias ans='ansible'
alias ansp='ansible-playbook'
alias ansd='ansible-doc'
alias ansg='ansible-galaxy'

if is-callable ansible-lint; then
  alias ansl='ansible-lint'
fi
