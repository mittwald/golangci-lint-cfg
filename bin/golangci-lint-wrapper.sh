#!/usr/bin/env bash

set -e

[[ -z "${DEBUG}" ]] || set -x

if [[ -f "${GOLANGCI_ADDITIONAL_YML}" ]]; then
  echo "Found additional .yml-config... trying to merge"
  ${YQ} eval-all --inplace 'select(fileIndex == 0) *+ select(fileIndex == 1) | .linters.disable = (.linters.disable | unique)' "${GOLANGCI_BASIC_YML}" "${GOLANGCI_ADDITIONAL_YML}"

fi

if [[ -n "${DEBUG}" ]]; then
  echo "---"
  cat "${GOLANGCI_BASIC_YML}"
  echo "---"
fi

exec "${GOLANGCI_LINT}" -c "${GOLANGCI_BASIC_YML}" $*
