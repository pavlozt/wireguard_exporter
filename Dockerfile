#build stage
FROM golang:1.20-alpine AS builder
WORKDIR /go/src/app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build  -o /go/bin -v  ./...

#final stage
FROM alpine:3
COPY --from=builder /go/bin/wireguard_exporter /wireguard_exporter
EXPOSE 9586
CMD ["/wireguard_exporter"]


LABEL Name=wireguard_exporter Version=0.2
