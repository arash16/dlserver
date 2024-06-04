FROM --platform=linux/amd64 node:lts-slim

ENV TZ=Asia/Tehran

RUN apt update -y && \
  apt install \
    aria2 curl wget python3 \
    wireguard iproute2 net-tools iptables -y && \
  cd /tmp && \
  curl -L https://github.com/ytdl-org/ytdl-nightly/releases/download/2024.05.31/youtube-dl -o /usr/bin/youtube-dl && \
  chmod a+rx /usr/bin/youtube-dl && \
  ln -s /usr/bin/python3 /usr/bin/python && \
  curl -fsSL git.io/wgcf.sh | bash && mkdir -p /wgcf && \
  ln -s /usr/bin/resolvectl /usr/local/bin/resolvconf

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn

COPY . .
ENTRYPOINT ["/app/entry.sh"]
