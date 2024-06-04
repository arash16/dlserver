FROM --platform=linux/amd64 node:20.13.1-alpine3.19

ENV TZ=Asia/Tehran

RUN apk add \
    aria2 curl wget python3 \
    wireguard-tools openresolv iproute2 net-tools iptables ca-certificates && \
  cd /tmp && \
  curl -L https://github.com/ytdl-org/ytdl-nightly/releases/download/2024.05.31/youtube-dl -o /usr/bin/youtube-dl && \
  chmod a+rx /usr/bin/youtube-dl && \
  curl -fsSL git.io/wgcf.sh | bash && mkdir -p /wgcf

RUN cd /tmp && curl -Ls https://github.com/arjonkman/phantomized/archive/refs/tags/latest.tar.gz | tar xz && \
    cp -R lib lib64 / && \
    cp -R usr/lib/x86_64-linux-gnu /usr/lib && \
    cp -R usr/share /usr/share && \
    cp -R etc/fonts /etc && \
    curl -k -Ls https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 | tar -jxf - && \
    cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin/phantomjs && \
    rm -fR phantomjs-2.1.1-linux-x86_64

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn && yarn global add phantomjs-prebuilt 

COPY . .
ENTRYPOINT ["/app/entry.sh"]
