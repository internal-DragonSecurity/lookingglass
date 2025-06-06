# lookingglass

Small golang to do network diagnostics

## Use the Docker image:

Head over to https://ghcr.io/dragonsecurity/lookingglass to view the latest builds and their checksums

```shell
docker pull ghcr.io/dragonsecurity/lookingglass:latest
docker run -p 4041:4041 ghcr.io/dragonsecurity/lookingglass:latest
```

## Build from source

```shell
go build -o lookingglass ./...
./lookingglass
```

## Connect to the server:
Connect to the web interface: http://localhost:4041
