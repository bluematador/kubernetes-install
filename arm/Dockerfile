FROM arm64v8/alpine:latest

ARG version=3.1.0

# Install dependencies and tools
RUN apk update && apk upgrade
RUN apk add --no-cache wget tar sudo

# Create a non-root user and group
RUN addgroup -g 1000 bmgroup && adduser -u 1000 -G bmgroup -S bmuser

# Creates an empty config.ini file
ADD config.ini /etc/bluematador-agent/config.ini

VOLUME "/app"
WORKDIR "/app/quartz"

# Creates Datadir directory
RUN mkdir -p /var/lib/bluematador-agent

# Download and extract the Bluematador agent
RUN wget -O bluematador-agent "https://bluematador-flint-modules.s3.amazonaws.com/quartz/bluematador-agent-${version}_arm64.tar.gz" && \
    tar -zxvf bluematador-agent && \
    rm bluematador-agent

# Adjust permissions
RUN sudo chown -R bmuser:bmgroup /var/lib/bluematador-agent
RUN sudo chown -R bmuser:bmgroup /etc/bluematador-agent
RUN sudo chown -R bmuser:bmgroup /app/quartz

# Switch to the non-root user
USER bmuser

# TODO after testing we have to change the verbosity level
CMD ["sh", "-c", "/app/quartz/usr/sbin/bluematador-agent -log stdout -verbose 2 -config /etc/bluematador-agent/config.ini -datadir /var/lib/bluematador-agent"]