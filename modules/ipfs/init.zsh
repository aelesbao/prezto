#
# Completion for IPFS (InterPlanetary File System).
#
# Authors:
#   Augusto Elesbao <aelesbao@gmail.com>
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

# Add zsh-ipfs to $fpath.
fpath=("${0:h}/external" $fpath)
