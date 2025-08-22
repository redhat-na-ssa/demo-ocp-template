#!/bin/bash
# set -x

usage(){
  echo "
    Usage:

    oc -n adhoc-admin \\
      replace cm adhoc-custom \\
      --dry-run=client \\
      --from-file=scripts/ \\
      -o yaml | oc replace -f -
  "
}

usage

exit 1
