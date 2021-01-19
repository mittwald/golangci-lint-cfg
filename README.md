# Golang CI Linter Config

## Usage
Copy the [`.golangci.yaml`](.golangci.yml) into your go project directory and run:

``
docker run -v $(go env GOPATH):/go -v $(pwd):/app -w /app --rm golangci/golangci-lint:v1.35 golangci-lint run -v ./...
``

## Recommended Goland Settings

* Settings > Tools > File Watcher: Add `go fmt`.
* Settings > Editor > Code Style > Go > Imports: Set `Sorting Type` to `goimports`.
* Settings > Editor > Code Style > Go > Other: Activate `Add leading space to comments`.