FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git
WORKDIR /go/src/helloworld/core
RUN git clone --progress https://github.com/jzp820927/xc.git . && \
    go mod download && \
    CGO_ENABLED=0 go build -o /tmp/helloworld -trimpath -ldflags "-s -w -buildid=" ./main

FROM alpine
COPY --from=builder /tmp/helloworld /usr/bin

ADD helloworld.sh /helloworld.sh
RUN chmod +x /helloworld.sh
CMD /helloworld.sh
