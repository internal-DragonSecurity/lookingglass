FROM golang:1.27-alpine@sha256:70bd7ddea8b6cbe5d6943cde279d6b67feb10cc924fb9100d1d8757c1575b280 AS builder
RUN apk --no-cache add git alpine-sdk

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o lookingglass ./cmd/web

FROM alpine@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b
RUN apk --no-cache add mtr bind-tools

COPY --from=builder /app/lookingglass /lookingglass
COPY --from=builder /app/assets /assets

ENTRYPOINT ["/lookingglass"]
EXPOSE 4041
