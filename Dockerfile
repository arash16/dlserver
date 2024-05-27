FROM --platform=linux/amd64 node:20.13.1-alpine3.19 as builder

ENV TZ=Asia/Tehran

RUN apk add aria2 curl wget && \
  cd /tmp && \
  curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl && \
  chmod a+rx /usr/bin/youtube-dl

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn

COPY . .
ENTRYPOINT ["node", "index"]
