#
# Defines Docker aliases.
#
# Author:
#   François Vantomme <akarzim@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[docker] )); then
  return 1
fi

#
# Functions
#

# Set Docker Machine environment
function dkme {
  if (( ! $+commands[docker-machine] )); then
    return 1
  fi

  eval $(docker-machine env $1)
}

# Set Docker Machine default machine
function dkmd {
  if (( ! $+commands[docker-machine] )); then
    return 1
  fi

  pushd ~/.docker/machine/machines

  if [[ ! -d $1 ]]; then
    echo "Docker machine '$1' does not exists. Abort."
    popd
    return 1
  fi

  if [[ -L default ]]; then
    eval $(rm -f default)
  elif [[ -d default ]]; then
    echo "A default machine already exists. Abort."
    popd
    return 1
  elif [[ -e default ]]; then
    echo "A file named 'default' already exists. Abort."
    popd
    return 1
  fi

  eval $(ln -s $1 default)
  popd
}

# Cleans stopped containers, dangling images, and dettached volumes
function dkclean {
  docker ps -a --quiet \
    -f 'status=created' \
    -f 'status=restarting' \
    -f 'status=removing' \
    -f 'status=paused' \
    -f 'status=exited' \
    -f 'status=dead' \
    | xargs -I {} docker rm {}
  docker images | grep '<none>' | awk '{print $3}' | xargs docker rmi
  docker volume prune
}
alias docker-clean='echo "Please run dkclean instead"'

# Source module files.
source "${0:h}/alias.zsh"
