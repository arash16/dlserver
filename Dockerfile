FROM --platform=linux/amd64 node:20.13.1-alpine3.19 as builder

ENV TZ=Asia/Tehran

RUN apk add curl wget gcc cmake make alpine-sdk
COPY install-tools.sh /tmp/install-tools.sh
RUN /tmp/install-tools.sh

# ================================================================

FROM --platform=linux/amd64 node:20.13.1-alpine3.19 as runner

COPY --from=builder /usr/local/bin/youtube-dl /usr/bin/youtube-dl
COPY --from=builder /usr/bin/aria2c /usr/bin/aria2c

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn

COPY . .
ENTRYPOINT ["node", "index"]
