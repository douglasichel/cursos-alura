FROM golang:1.21-alpine AS builder

WORKDIR /build

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o main .

FROM alpine:latest

EXPOSE 8000

WORKDIR /app

COPY --from=builder /build/main .

CMD ["./main"]
