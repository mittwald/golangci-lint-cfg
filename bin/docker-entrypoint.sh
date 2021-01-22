#!/usr/bin/env bash

set -e

[[ -z "${DEBUG}" ]] || set -x

if [[ -f "${GOLANGCI_ADDITIONAL_YML}" ]]; then
  echo "Found additional .yml-config... trying to merge"
  ${YQ} merge -x --inplace "${GOLANGCI_BASIC_YML}" "${GOLANGCI_ADDITIONAL_YML}"

  if [[ -n "${DEBUG}" ]]; then
    echo "---"
    cat "${GOLANGCI_BASIC_YML}"
    echo "---"
  fi
fi

$*