FROM ubuntu:22.04
WORKDIR /var/app
RUN apt -q update && apt install -yq make gcc git curl && \
cd /tmp && \
git clone -q https://github.com/janet-lang/janet.git && \
cd janet && \
make all test install && \
rm -rf /tmp/janet && \
chmod 777 /usr/local/lib/janet && \
cd /tmp && \
git clone -q --depth=1 https://github.com/janet-lang/jpm.git && \
cd jpm && \
janet -q bootstrap.janet && \
cp ./jpm/jpm /usr/local/lib/jpm && \
chmod 777 /usr/local/lib/jpm && \
janet -v && jpm -v
ARG GID=1000
ARG UID=1000
ARG USER=me
RUN groupadd -g $GID $USER && useradd -g $GID -M -u $UID -d /var/app $USER && \
chmod 777 /var/app
USER $USER
CMD ["janet"]
