FROM        golangci/golangci-lint:v1.49.0

ENV         LINT_NAME="mittwald-golangci" \
            LINT_ID="1000" \
            GOLANGCI_ADDITIONAL_YML="/.golangci.yml" \
            YQ="/usr/bin/yq" \
            GOLANGCI_LINT="/usr/bin/golangci-lint-orig"

ENV         GOLANGCI_BASIC_YML="/home/${LINT_NAME}/.golangci.yml"

USER        root

RUN         set -xe \
            && \
            apt-get update && apt-get install make gosu -y \
            && \
            groupadd --gid "${LINT_ID}" "${LINT_NAME}" \
            && \
            useradd --uid "${LINT_ID}" --gid "${LINT_NAME}" --shell /bin/bash --create-home "${LINT_NAME}" \
            && \
            mv /usr/bin/golangci-lint "${GOLANGCI_LINT}" \
            && \
            apt-get autoclean -y && apt-get autoremove -y \
            && \
            rm -rf /tmp/* /var/cache/*

COPY        --chown=1000:1000 .golangci.yml ${GOLANGCI_BASIC_YML}

COPY        --from=mikefarah/yq:4.13.0 /usr/bin/yq ${YQ}

COPY        bin/golangci-lint-wrapper.sh /usr/bin/golangci-lint
COPY        bin/mw-entrypoint.sh /bin/mw-entrypoint

ENV         PATH="/usr/bin:${PATH}"

ENTRYPOINT  ["mw-entrypoint"]
