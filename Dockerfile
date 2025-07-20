FROM node:24-alpine

ARG GEMINI_CLI_VERSION=latest

RUN apk add --no-cache \
    bash \
    curl \
    git

WORKDIR /work

RUN npm install -g @google/gemini-cli@${GEMINI_CLI_VERSION}
