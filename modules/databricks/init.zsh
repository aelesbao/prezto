#
# Defines utility functions to work with Databricks
#
# Author:
#   Augusto Elesbao <aelesbao@gmail.com>
#

function databricks-cluster-by-name() {
  local cluster_name="$1"

  databricks clusters list --output JSON | jq -r ".clusters[] | select(.cluster_name == \"$cluster_name\")"
}

function databricks-cluster-dns() {
  local cluster_name="$1"

  databricks-cluster-by-name "$cluster_name" | jq -r '.driver.public_dns'
}

function databricks-cluster-ssh() {
  local cluster_name="$1"
  local cluster_dns="$(databricks-cluster-dns "$cluster_name")"

  ssh "ubuntu@$cluster_dns" -p 2200
}
