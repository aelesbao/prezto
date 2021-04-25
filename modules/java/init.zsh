#
# Java utilities
#
# Authors:
#   Augusto Elesbao <http://github.com/aelesbao>
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

source "${0:h}/external/jenv-lazy.plugin.zsh"
