#
# Defines tmux aliases and provides for auto launching it at start-up.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Colin Hebert <hebert.colin@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[tmux] )); then
  return 1
fi

#
# Auto Start
#

if [[ -z "$TMUX" ]] && zstyle -t ':prezto:module:tmux' auto-start; then
  tmux_session='default'

  if ! tmux has-session -t "$tmux_session" 2> /dev/null; then
    # Create a new session.
    tmux new-session -d -s "$tmux_session"
  fi

  exec tmux attach-session -t "$tmux_session"
fi

if [[ -n "$TMUX" ]]; then
  if zstyle -t ':prezto:module:tmux' powerline; then
    tmux-powerline
  fi
fi

#
# Aliases
#

alias tmuxa='tmux attach-session'
alias tmuxl='tmux list-sessions'
