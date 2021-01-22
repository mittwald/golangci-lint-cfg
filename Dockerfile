FROM        golangci/golangci-lint:v1.35.2

ENV         LINT_NAME="mittwald-golangci" \
            LINT_ID="1000" \
            GOLANGCI_ADDITIONAL_YML="/.golangci.yml" \
            YQ="/usr/bin/yq" \
            GOLANGCI_LINT="/usr/bin/golangci-lint-orig"

ENV         GOLANGCI_BASIC_YML="/home/${LINT_NAME}/.golangci.yml"

RUN         set -xe \
            && \
            apt-get update && apt-get install make -y \
            && \
            groupadd --gid "${LINT_ID}" "${LINT_NAME}" \
            && \
            useradd --uid "${LINT_ID}" --gid "${LINT_NAME}" --shell /bin/bash --create-home "${LINT_NAME}" \
            && \
            mv /usr/bin/golangci-lint "${GOLANGCI_LINT}" \
            && \
            rm -rf /tmp/* /var/cache/*

COPY        --chown=1000:1000 .golangci.yml ${GOLANGCI_BASIC_YML}

# do not update this to v4 because it lacks the "merge"-command
COPY        --from=mikefarah/yq:3.4.1 /usr/bin/yq ${YQ}

COPY        --chown=1000:1000 bin/golangci-lint-wrapper.sh /usr/bin/golangci-lint

USER        ${LINT_ID}:${LINT_ID}