FROM alpine:3.8

ARG version=3.1.10
ENV BLUEMATADOR_VERBOSE=2

# Symlink the compatible muslc dependencies
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

# Certificates for SSL
RUN apk add --update ca-certificates

RUN mkdir /var/lib/bluematador-agent
ADD config.ini /etc/bluematador-agent/config.ini

RUN wget -O bluematador-agent "https://s3://bluematador-staging-flint-modules/quartz/bluematador-agent-3.1.0_amd64.tar.gz" && tar -zxvf bluematador-agent && rm bluematador-agent

CMD ["sh", "-c", "/usr/sbin/bluematador-agent -log stdout -verbose ${BLUEMATADOR_VERBOSE} -config /etc/bluematador-agent/config.ini -datadir /var/lib/bluematador-agent"]