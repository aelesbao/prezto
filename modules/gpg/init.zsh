#
# Provides for an easier use of GPG by setting up gpg-agent.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[gpg-agent] )); then
  return 1
fi

# Set the default paths to gpg-agent files.
export GNUPGHOME="${GNUPGHOME:-$(gpgconf --list-dirs homedir)}"
_gpg_agent_conf="${GNUPGHOME:-$HOME/.gnupg}/gpg-agent.conf"
_gpg_agent_env="${XDG_CACHE_HOME:-$HOME/.cache}/prezto/gpg-agent.env"
_gpg_agent_socket="$(gpgconf --list-dirs agent-socket 2>/dev/null || echo "${${XDG_RUNTIME_DIR:+$XDG_RUNTIME_DIR/gnupg}:-${GNUPGHOME:-$HOME/.gnupg}}/S.gpg-agent")"

# Load environment variables from previous run
source "$_gpg_agent_env" 2> /dev/null

# Start gpg-agent if not started.
if [[ -z "$GPG_AGENT_INFO" && ! -S "${_gpg_agent_socket}" ]]; then
  # Start gpg-agent if not started.
  if ! ps -U "$LOGNAME" -o pid,ucomm | grep -q -- "${${${(s.:.)GPG_AGENT_INFO}[2]}:--1} gpg-agent"; then
    mkdir -p "$_gpg_agent_env:h"
    eval "$(gpg-agent --daemon | tee "$_gpg_agent_env")"
  fi
fi

# Inform gpg-agent of the current TTY for user prompts.
export GPG_TTY=$TTY

# Integrate with the SSH module.
if grep '^enable-ssh-support' "$_gpg_agent_conf" &> /dev/null; then
  # Load required functions.
  autoload -Uz add-zsh-hook

  # Override the ssh-agent environment file default path.
  _ssh_agent_env="$_gpg_agent_env"

  unset SSH_AGENT_PID
  if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  fi

  # Load the SSH module for additional processing.
  pmodload 'ssh'

  # Updates the GPG-Agent TTY before every command since SSH does not set it.
  function _gpg-agent-update-tty {
    gpg-connect-agent UPDATESTARTUPTTY /bye >/dev/null
  }
  add-zsh-hook preexec _gpg-agent-update-tty
fi

# Clean up.
unset _gpg_agent_{conf,env,socket}

# Disable GUI prompts inside SSH.
if [[ -n "$SSH_CONNECTION" ]]; then
  export PINENTRY_USER_DATA='USE_CURSES=1'
fi
