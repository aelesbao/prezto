#
# Kitty utilities
#
# Authors:
#   Augusto Elesbao <http://github.com/aelesbao>
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

# Kitty aliases
if [[ "$TERM" == "xterm-kitty" ]]; then
  alias icat='kitty kitten icat'

  # Fix for broken SSH output when using Kitty
  alias ssh='TERM=xterm-256color ssh'
fi

function kitty-set-theme() {
  kitty +kitten themes --reload-in all
  [[ -f ~/.config/kitty/kitty.conf.bak ]] && mv ~/.config/kitty/kitty.conf.bak ~/.config/kitty/kitty.conf
}

function kitty-remote() {
  kitty -o allow_remote_control=yes &
}

