### Source
- https://github.com/chenhw2/Dockers/tree/GO-SS2
  
### Thanks to
- [https://github.com/shadowsocks/go-shadowsocks2][ss2ver]
  
### Usage
```
$ docker pull chenhw2/go-ss2

$ docker run -d \
    -e "ARGS=-s ss://AEAD_CHACHA20_POLY1305:your-password@:8488" \
    -p 8488:8488/tcp -p 8488:8488/udp \
    chenhw2/go-ss2
```

### ENV
```
ENV ARGS="-s ss://AEAD_CHACHA20_POLY1305:your-password@:8488"
```

 [ss2ver]: https://github.com/shadowsocks/go-shadowsocks2/commit/de996c889eae0ad0356d654eff7b2ff7aa489096
