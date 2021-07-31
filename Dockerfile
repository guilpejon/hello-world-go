FROM golang:1.17rc1-buster AS builder
WORKDIR /app
COPY . .
RUN apt-get update -y && \
    apt-get install -y upx
RUN go get github.com/pwaller/goupx && \
    go mod init hello && \
    go build -ldflags "-s -w" -o hello && \
    goupx --brute hello

FROM scratch
WORKDIR /app
COPY --from=builder /app/hello .
CMD ["./hello"]
