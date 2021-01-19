# Golang CI Linter Config

## Usage

```shell
$ docker run -v $(go env GOPATH):/go -v $(pwd):/app -w /app --rm quay.io/mittwlad/golangci-lint:latest golangci-lint run -v ./...
```

## Recommended Goland Settings

* Settings > Tools > File Watcher: Add `go fmt`.
* Settings > Editor > Code Style > Go > Imports: Set `Sorting Type` to `goimports`.
* Settings > Editor > Code Style > Go > Other: Activate `Add leading space to comments`.
