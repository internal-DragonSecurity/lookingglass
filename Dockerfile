FROM golang:1.25-alpine@sha256:26111811bc967321e7b6f852e914d14bede324cd1accb7f81811929a6a57fea9 AS builder
RUN apk --no-cache add git alpine-sdk

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o lookingglass ./cmd/web

FROM alpine@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412
RUN apk --no-cache add mtr bind-tools

COPY --from=builder /app/lookingglass /lookingglass
COPY --from=builder /app/assets /assets

ENTRYPOINT ["/lookingglass"]
EXPOSE 4041
