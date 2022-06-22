#!/usr/bin/env bash

set -e

[[ -z "${DEBUG}" ]] || set -x

if [[ ! "$(id -u "${LINT_NAME}")" -eq "${LINT_ID}" ]] || [[ ! "$(id -g "${LINT_NAME}")" -eq "${LINT_ID}" ]]; then
  TMP_HOME="/tmp/home-${LINT_NAME}"
  mkdir -p "${TMP_HOME}"

  usermod -d "${TMP_HOME}" "${LINT_NAME}"

  usermod -o -u "${LINT_ID}" "${LINT_NAME}"
  groupmod -o -g "${LINT_ID}" "${LINT_NAME}"

  usermod -d "/home/${LINT_NAME}" "${LINT_NAME}"

  rm -rf "${TMP_HOME}"
fi

gosu "${LINT_NAME}" bash -c "$*"
