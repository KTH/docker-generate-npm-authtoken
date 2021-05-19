FROM node:16-alpine

RUN apk update && \
    apk upgrade && \
    apk add --no-cache expect && \
    rm -rf /var/cache/apk/*

# Copy the login scripts
COPY bin/ /usr/local/bin

CMD ["bin/sh", "/usr/local/bin/npm.sh"]
