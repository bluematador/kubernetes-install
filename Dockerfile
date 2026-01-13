FROM alpine:3.23.2
ARG version=3.3.1
ENV BLUEMATADOR_VERBOSE=2
RUN arch=$(uname -m) && \
    if [ "$arch" = "x86_64" ]; then echo "platform=amd64" >> /etc/environment; \
    elif [ "$arch" = "aarch64" ]; then echo "platform=arm64" >> /etc/environment; \
    else echo "Unsupported architecture: $arch" && exit 1; fi
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
RUN source /etc/environment && \
    echo "https://bluematador-flint-modules.s3.amazonaws.com/quartz/bluematador-agent-${version}_${platform}.tar.gz" && \
    wget -O bluematador-agent "https://bluematador-flint-modules.s3.amazonaws.com/quartz/bluematador-agent-${version}_${platform}.tar.gz" && \
    tar -zxvf bluematador-agent && \
    rm bluematador-agent
# Adjust permissions
RUN sudo chown -R bmuser:bmgroup /var/lib/bluematador-agent
RUN sudo chown -R bmuser:bmgroup /etc/bluematador-agent
RUN sudo chown -R bmuser:bmgroup /app/quartz
# Switch to the non-root user
USER bmuser

CMD ["sh", "-c", "/app/quartz/usr/sbin/bluematador-agent -log stdout -verbose ${BLUEMATADOR_VERBOSE} -config /etc/bluematador-agent/config.ini -datadir /var/lib/bluematador-agent"]
