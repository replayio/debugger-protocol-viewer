VERSION --parallel-load 0.6

FROM --platform linux/amd64 node:16.13-bullseye-slim
WORKDIR /usr/build
ENV EARTHLY=true

build:
  COPY . .
  RUN npm ci
  RUN npm i @replayio/protocol@latest
  RUN npm run prep
  RUN npm run build
  SAVE ARTIFACT protocol AS LOCAL protocol