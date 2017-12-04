#
# Dockerfile for shadowsocks-libev and simple-obfs
#
FROM ubuntu:16.04 as builder

ARG BUILD_SH=https://gist.github.com/chenhw2/e57359378cd4699d19d10eb34f8069b4/raw/3b712141cb20b611b8dbbaa4a58e3bf291b21663/cross_and_static_compile_shadowsocks-libev.sh

RUN apt-get update && apt-get install build-essential automake autoconf libtool wget git clang -yqq
RUN set -ex && cd / && \
    wget -qO- $BUILD_SH | sed '/_proxy/d; /^compile_shadowsocksr_libev$/d' > /build.sh && \
    chmod +x /build.sh && \
    /build.sh

FROM chenhw2/alpine:base
MAINTAINER CHENHW2 <https://github.com/chenhw2>

COPY --from=builder /dists/shadowsocks-libev/bin /usr/bin

ENV SERVER_PORT=8388 \
    METHOD=chacha20-ietf-poly1305 \
    TIMEOUT=120
ENV PASSWORD=''
ENV ARGS='-d 8.8.8.8'

EXPOSE $SERVER_PORT/tcp $SERVER_PORT/udp

CMD ss-server \
 -s 0.0.0.0 \
 -p $SERVER_PORT \
 -k ${PASSWORD:-$(hostname)} \
 -m $METHOD \
 -t $TIMEOUT \
 --fast-open \
 --no-delay \
 -u \
 ${ARGS}
