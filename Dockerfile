FROM golang:1.25-alpine@sha256:72567335df90b4ed71c01bf91fb5f8cc09fc4d5f6f21e183a085bafc7ae1bec8 AS builder
RUN apk --no-cache add git alpine-sdk

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o lookingglass ./cmd/web

FROM alpine@sha256:865b95f46d98cf867a156fe4a135ad3fe50d2056aa3f25ed31662dff6da4eb62
RUN apk --no-cache add mtr bind-tools

COPY --from=builder /app/lookingglass /lookingglass
COPY --from=builder /app/assets /assets

ENTRYPOINT ["/lookingglass"]
EXPOSE 4041
