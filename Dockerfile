FROM --platform=linux/amd64 node:20.13.1-alpine3.19 as builder

ENV TZ=Asia/Tehran

RUN apk add aria2 curl wget python3 && \
  cd /tmp && \
  curl -L https://github.com/ytdl-org/ytdl-nightly/releases/download/2024.05.31/youtube-dl -o /usr/bin/youtube-dl && \
  chmod a+rx /usr/bin/youtube-dl

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn

COPY . .
ENTRYPOINT ["node", "index"]
