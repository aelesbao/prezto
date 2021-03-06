#
# Defines systemctl aliases.
#
# Authors:
#   Augusto Rocha Elesbão <aelesbao@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[systemctl] )); then
  return 1
fi

user_commands=(
  list-units is-active status show help list-unit-files
  is-enabled list-jobs show-environment
)

for c in $user_commands; do; alias sc-$c="systemctl $c"; done

unset user_commands

sudo_commands=(
  start stop reload restart try-restart isolate kill
  reset-failed enable disable reenable preset mask unmask
  link load cancel set-environment unset-environment
)

for c in $sudo_commands; do; alias sc-$c="sudo systemctl $c"; done

unset sudo_commands
