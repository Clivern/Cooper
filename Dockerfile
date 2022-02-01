FROM golang:1.17.6

ARG APP_VERSION=1.0.0

ENV GO111MODULE=on

RUN mkdir -p /app/configs
RUN mkdir -p /app/var/logs
RUN apt-get update

WORKDIR /app

RUN curl -sL https://github.com/Clivern/kevent/releases/download/v${APP_VERSION}/kevent_${APP_VERSION}_Linux_x86_64.tar.gz | tar xz
RUN rm LICENSE
RUN rm README.md

COPY ./config.dist.yml /app/configs/

EXPOSE 8000

VOLUME /app/configs
VOLUME /app/var

RUN ./kevent version

CMD ["./kevent", "server", "-c", "/app/configs/config.dist.yml"]
