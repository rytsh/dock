# Local Go PKG

Use `build.sh` or build directly:

```sh
docker build --build-arg GOPROXY=http://172.17.0.1:4444 -t gopkg:test - < Dockerfile
```

Run with specified env variables
```sh
docker run --rm -it -p 8080:8080 -e GO_DISCOVERY_DATABASE_HOST=172.17.0.1 -e GO_DISCOVERY_DATABASE_NAME=postgres -e GOPROXY=http://172.17.0.1:4444 gopkg:test -proxy_url http://172.17.0.1:4444
```

## Set environment variables

To get details https://github.com/golang/pkgsite/blob/master/internal/config/config.go

| Variable                             | Value                 |
| ------------------------------------ | --------------------- |
| GOPROXY                              | http://localhost:4444 |
| GO_DISCOVERY_DATABASE_HOST           | localhost             |
| GO_DISCOVERY_DATABASE_PORT           | 5432                  |
| GO_DISCOVERY_DATABASE_USER           | postgres              |
| GO_DISCOVERY_DATABASE_PASSWORD       | -                     |
| GO_DISCOVERY_DATABASE_SECONDARY_HOST | localhost             |
| GO_DISCOVERY_DATABASE_NAME           | discovery-db          |
| GO_DISCOVERY_DATABASE_SSL            | disable               |

## Without using container, details (skip this steps)

Create and Migrate database

```sh
go run ./devtools/cmd/db/main.go create &&
go run ./devtools/cmd/db/main.go migrate &&
```

Example run of binary `frontend`

```
GO_DISCOVERY_DATABASE_HOST=172.17.0.1 GO_DISCOVERY_DATABASE_NAME=postgres GOPROXY=http://172.17.0.1:4444 frontend -host 0.0.0.0:8080 -proxy_url http://172.17.0.1:4444
```
