#!/usr/bin/env bash

set -e

[[ -z "${DEBUG}" ]] || set -x

if [[ -f "${GOLANGCI_ADDITIONAL_YML}" ]]; then
  echo "Found additional .yml-config... trying to merge"
  ${YQ} eval-all --inplace 'select(fileIndex == 0) *+ select(fileIndex == 1) | .linters.disable = (.linters.disable | unique)' "${GOLANGCI_BASIC_YML}" "${GOLANGCI_ADDITIONAL_YML}"

fi

if [[ -n "${CREATE_WORKDIR_GOLANGCI_YML}" ]]; then
  echo "\${CREATE_WORKDIR_GOLANGCI_YML} is set, creating a '.golangci.yml' in '${PWD}'"
  cp -a "${GOLANGCI_BASIC_YML}" "${PWD}/.golangci.yml"
fi

if [[ -n "${DEBUG}" ]]; then
  echo "---"
  cat "${GOLANGCI_BASIC_YML}"
  echo "---"
fi

CONFIG_FLAG="-c ${GOLANGCI_BASIC_YML}"
if [[ "${1}" != "run" ]]; then
  CONFIG_FLAG=""
fi

exec "${GOLANGCI_LINT}" ${CONFIG_FLAG} $*
