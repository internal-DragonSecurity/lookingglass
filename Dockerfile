FROM golang:1.26-alpine@sha256:f1ddd9fe14fffc091dd98cb4bfa999f32c5fc77d2f2305ea9f0e2595c5437c14 AS builder
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
