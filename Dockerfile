FROM golang:alpine as builder
RUN apk add --update git
RUN go get github.com/shadowsocks/go-shadowsocks2


FROM chenhw2/alpine:base
MAINTAINER CHENHW2 <https://github.com/chenhw2>

# /usr/bin/go-shadowsocks2
COPY --from=builder /go/bin /usr/bin

USER nobody
ENV ARGS="-s ss://AEAD_CHACHA20_POLY1305:your-password@:8488"
EXPOSE 8488/tcp 8488/udp

CMD /usr/bin/go-shadowsocks2 ${ARGS} -verbose
