FROM        golangci/golangci-lint:v1.35.2

ENV         LINT_NAME="mittwald-golangci" \
            LINT_ID="1000" \
            GOLANGCI_ADDITIONAL_YML="/.golangci.yml" \
            YQ="/usr/bin/yq"

ENV         GOLANGCI_BASIC_YML="/home/${LINT_NAME}/.golangci.yml"

RUN         set -xe \
            && \
            apt-get update && apt-get install make -y \
            && \
            groupadd --gid "${LINT_ID}" "${LINT_NAME}" \
            && \
            useradd --uid "${LINT_ID}" --gid "${LINT_NAME}" --shell /bin/bash --create-home "${LINT_NAME}" \
            && \
            apt-get autoremove -y && apt-get autoclean -y \
            && \
            rm -rf /tmp/* /var/cache/*

COPY        --chown=1000:1000 .golangci.yml ${GOLANGCI_BASIC_YML}

# do not update this to v4 because it lacks the "merge"-command
COPY        --from=mikefarah/yq:3.4.1 /usr/bin/yq ${YQ}

COPY        bin/docker-entrypoint.sh /entrypoint.sh

USER        ${LINT_ID}:${LINT_ID}

ENTRYPOINT ["/entrypoint.sh"]
CMD        ["golangci-lint"]
