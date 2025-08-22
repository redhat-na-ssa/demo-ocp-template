#!/bin/bash
# set -e

# shellcheck disable=SC2034

################# standard init #################

# 8 seconds is usually enough time for the average user to realize they foobar
export SLEEP_SECONDS=8

check_git_root(){
  if [ -d .git ] && [ -d scripts ]; then
    GIT_ROOT=$(pwd)
    export GIT_ROOT
    echo "GIT_ROOT: ${GIT_ROOT}"
  else
    echo "Please run this script from the root of the git repo"
    exit
  fi
}

check_script_path(){
  SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
  echo "SCRIPT_DIR: ${SCRIPT_DIR}"
}

until_true(){
  echo "Running:" "${@}"
  echo "Press <ctrl> + c to cancel"
  until "${@}" 1>&2
  do
    echo "again..."
    sleep 20
  done

  echo "[OK]"
}

apply_firmly(){
  if [ ! -f "${1:-.}/kustomization.yaml" ]; then
    echo "Please provide a dir with 'kustomization.yaml'"
    echo "'kustomization.yaml' not found in ${1}"
    return 1
  fi

  # until oc kustomize "${1}" --enable-helm | oc apply -f- 2>/dev/null
  until_true oc apply -k "${1}" 2>/dev/null
}

check_git_root
check_script_path

# manage args passed to script
if [ -z ${1+x} ]; then
  echo "MODE: NON INTERACTIVE"
  
  apply_firmly demo
else
  echo ${@}
fi
