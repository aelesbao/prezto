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

# Add completions to $fpath.
fpath=("${0:h}/functions" $fpath)

function k-remote() {
  kitty -o allow_remote_control=yes &
}

function k-test-theme() {
  local theme="$1"
  if ! [[ -f "$theme" ]]; then
    echo "Theme file not found: $theme"
    exit 1
  fi

  kitty @ set-colors -a -c "$theme"
}

function k-set-theme() {
  local theme="$1"
  if ! [[ -f "$theme" ]]; then
    echo "Theme file not found: $theme"
    exit 1
  fi

  ln -sf "$theme" ~/.config/kitty/theme.conf
}

