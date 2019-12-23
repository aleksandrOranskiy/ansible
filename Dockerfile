FROM node:11.15.0

ENV NODE_ENV development
ENV npm_config_loglevel warn

# Create app directory
WORKDIR /usr/src/app
