#!/usr/bin/env bash

set -e

isCommand() {
   /usr/bin/golangci-lint-orig "${1}" --help > /dev/null 2>&1
}

[[ -z "${DEBUG}" ]] || set -x

if [[ ! "$(id -u "${LINT_NAME}")" -eq "${LINT_ID}" ]] || [[ ! "$(id -g "${LINT_NAME}")" -eq "${LINT_ID}" ]]; then
  usermod -o -u "${LINT_ID}" "${LINT_NAME}"
  groupmod -o -g "${LINT_ID}" "${LINT_NAME}"
fi

if [ "${1#-}" != "$1" ]; then
  exec gosu "${LINT_NAME}" /usr/bin/golangci-lint "run $*"
elif [ "$1" = 'golangci-lint' ]; then
  exec gosu "${LINT_NAME}" $@
elif isCommand "$1"; then
  exec gosu "${LINT_NAME}" /usr/bin/golangci-lint "$@"
fi

exec "${@}"
