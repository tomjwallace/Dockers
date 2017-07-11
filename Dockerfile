FROM chenhw2/alpine:base
MAINTAINER CHENHW2 <https://github.com/chenhw2>

ARG SS2_URL=https://github.com/riobard/go-shadowsocks2/releases/download/v0.0.9/shadowsocks2-linux-x64.gz

# /usr/bin/go-ss2
RUN set -ex && \
    apk add --update --no-cache --virtual gzip \
    && wget -qO- ${SS2_URL} | gzip -d > /usr/bin/go-ss2 \
    && chmod +x /usr/bin/go-ss2 \
    && apk del --purge gzip \
    && rm -rf /tmp/* /var/cache/apk/*

USER nobody
ENV ARGS="-s ss://AEAD_CHACHA20_POLY1305:your-password@:8488"
EXPOSE 8488/tcp 8488/udp

CMD /usr/bin/go-ss2 ${ARGS} -verbose
