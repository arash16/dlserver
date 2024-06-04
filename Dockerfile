FROM --platform=linux/amd64 node:lts-slim

ENV TZ=Asia/Tehran

RUN apt update -y && \
  apt install aria2 curl wget python3 -y && \
  cd /tmp && \
  curl -L https://github.com/ytdl-org/ytdl-nightly/releases/download/2024.05.31/youtube-dl -o /usr/bin/youtube-dl && \
  chmod a+rx /usr/bin/youtube-dl && \
  ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn

COPY . .
ENTRYPOINT ["node", "index"]
