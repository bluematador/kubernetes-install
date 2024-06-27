
FROM arm64v8/ubuntu

ARG version=3.1.0

# create a new user with less privileges than root

ENV GO_VERSION="1.22.2" \
    PATH="${PATH}:/home/user/go/bin" \
    GOPATH="/home/user/app/quartz" \
    GOBIN="/home/user/app/quartz/bin"

RUN groupadd -r user --gid="1000"
RUN adduser --home "/home/user" --gid "1000" --disabled-password --disabled-login --gecos '' --shell "/bin/bash" --uid "1000" user

## install dependencies and tools
RUN apt-get update
## install golang
RUN apt-get install -y wget telnet iptables net-tools dnsutils netcat

RUN wget -q -O - "https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C "/home/user" -xzf -
## install other build tools
RUN apt-get install -y make git curl fakeroot rpm msitools dos2unix
## Install cgo dependencies
RUN apt-get install -y gcc libpcap-dev
## cgo for windows
RUN apt-get install -y gcc-mingw-w64
## clean up apt
RUN rm -rf /var/lib/apt/lists/*


## change ownership of the installed go under /home/user folder and switch to user
RUN mkdir -p /usr/local/share/bluematador \
    && chown user:user /usr/local/share/bluematador

ADD config.ini /app/quartz/conf/config.ini
RUN chmod 777 /app/quartz/conf/config.ini

VOLUME "/app"
WORKDIR "/app/quartz"

#RUN mkdir -p /var/lib/bluematador && chmod 777 /var/lib/bluematador

RUN wget -O bluematador-agent "https://bluematador-staging-flint-modules.s3.amazonaws.com/quartz/bluematador-agent-3.1.0_arm64.tar.gz" && tar -zxvf bluematador-agent && rm bluematador-agent

#USER 1000

RUN echo "/app/quartz/usr/sbin/bluematador-agent" | tee /usr/local/share/bluematador/exe-location

CMD ["sh", "-c", "/app/quartz/usr/sbin/bluematador-agent -log stdout -verbose 5 -config /app/quartz/conf/config.ini -datadir /usr/local/share/bluematador"]


#COPY docker-entrypoint.sh /home/user/docker-entrypoint.sh
#
#RUN mkdir -p -m 777 "/home/user/bluematador"
#
#WORKDIR "/home/user/app/quartz"
#RUN wget -O bluematador-agent "https://bluematador-staging-flint-modules.s3.amazonaws.com/quartz/bluematador-agent-3.1.0_arm64.tar.gz" && tar -zxvf bluematador-agent && rm bluematador-agent
#
#RUN install -m 0644 -o 1000 -g 1000 "/home/user/app/quartz/conf/config.ini" "/home/user/app/quartz/conf/config.local.ini"
#
##ENTRYPOINT ["/home/user/docker-entrypoint.sh"]
#
#CMD ["sh", "-c", "/home/user/app/quartz/usr/sbin/bluematador-agent -log stdout -verbose 5 -config /home/user/app/quartz/conf/config.local.ini -datadir /home/user/bluematador", "|" ,"tee","/home/user/bluematador/exe-location"]