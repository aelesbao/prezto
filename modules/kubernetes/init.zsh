#
# Kubernetes shortcuts
#
# Authors:
#   Augusto Elesbao <http://github.com/aelesbao>
#


# Return if requirements are not found.
if ! is-callable kubectl; then
  return 1
fi

function kubectl-completion() {
  source <(kubectl completion zsh)
}

# Lazy load kubectl completion
function kubectl() {
  unset -f kubectl
  kubectl-completion
  kubectl $@
}

alias k="kubectl"
