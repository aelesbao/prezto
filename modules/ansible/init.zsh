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
alias anp='ansible-playbook'
alias and='ansible-doc'
alias ang='ansible-galaxy'

if is-callable ansible-lint; then
  alias anl='ansible-lint'
fi
