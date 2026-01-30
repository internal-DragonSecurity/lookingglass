FROM golang:1.25-alpine@sha256:98e6cffc31ccc44c7c15d83df1d69891efee8115a5bb7ede2bf30a38af3e3c92 AS builder
RUN apk --no-cache add git alpine-sdk

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o lookingglass ./cmd/web

FROM alpine@sha256:25109184c71bdad752c8312a8623239686a9a2071e8825f20acb8f2198c3f659
RUN apk --no-cache add mtr bind-tools

COPY --from=builder /app/lookingglass /lookingglass
COPY --from=builder /app/assets /assets

ENTRYPOINT ["/lookingglass"]
EXPOSE 4041
