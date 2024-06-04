FROM --platform=linux/amd64 node:20.13.1-alpine3.19

ENV TZ=Asia/Tehran

RUN apk add \
    aria2 curl wget python3 \
    wireguard-tools openresolv iproute2 net-tools iptables ca-certificates && \
  cd /tmp && \
  curl -L https://github.com/ytdl-org/ytdl-nightly/releases/download/2024.05.31/youtube-dl -o /usr/bin/youtube-dl && \
  chmod a+rx /usr/bin/youtube-dl && \
  curl -fsSL git.io/wgcf.sh | bash && mkdir -p /wgcf

RUN set -ex \
  && apk add --no-cache --virtual .build-deps ca-certificates openssl \
  && curl -Ls "https://github.com/arjonkman/phantomized/archive/refs/tags/latest.tar.gz" | tar xz -C \
  && yarn global add phantomjs \
  && apk del .build-deps

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn && yarn global add phantomjs-prebuilt 

COPY . .
ENTRYPOINT ["/app/entry.sh"]
