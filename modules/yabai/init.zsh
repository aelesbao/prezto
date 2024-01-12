#
# Helpers for the Yabai window manager.
#
# Authors:
#   Augusto Elesbão <aelesbao@users.noreply.github.com>
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]] || ! is-callable yabai; then
  return 1
fi

alias ybc='yabai -m config'
alias ybd='yabai -m display'
alias ybs='yabai -m space'
alias ybw='yabai -m window'
alias ybq='yabai -m query'
alias ybr='yabai -m rule'
alias ybs='yabai -m signal'
