FROM docker.io/alpine:3.11
ARG JANET=1.12.2
ARG USER=app
ARG GROUP=app
ARG GID=1000
ARG UID=1000
WORKDIR /tmp
RUN apk add --no-cache build-base curl git && \
addgroup -g $GID -S $GROUP && \
adduser -u $UID -S $USER -G $GROUP && \
git clone -q --depth 1 --branch v$JANET https://github.com/janet-lang/janet.git . && \
make all test install && \
chmod 777 /usr/local/lib/janet && \
janet -v && jpm -v &&  jpm --help && \
jpm install joy && \
chown -R $USER:$GROUP /usr/local/lib/janet/joy && \
mkdir -p /var/app && \
chown -R $USER:$GROUP /var/app
WORKDIR /var/app
USER $USER
CMD ["janet"]
