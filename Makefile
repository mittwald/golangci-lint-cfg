.PHONY: all
all: test

.PHONY: test
test:
	docker build -t linttestimage .
	docker run --rm linttestimage \
             golangci-lint run -v ./...
