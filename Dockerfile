FROM node:24-alpine

ARG GEMINI_CLI_VERSION=0.5.1

RUN apk add --no-cache \
    bash \
    curl \
    git

WORKDIR /work

RUN npm install -g @google/gemini-cli@${GEMINI_CLI_VERSION}
