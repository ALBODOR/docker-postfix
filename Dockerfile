FROM sameersbn/ubuntu:14.04.20170123
MAINTAINER ELOUIZ BADR <elouiz.badr@gmail.com>

RUN apt-get update &&\
 DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
 supervisor postfix nano mailutils telnet && \
 apt-get clean && apt-get autoclean && \
 rm -rf /var/lib/apt/lists/*

COPY assets/configure.sh /

ENTRYPOINT ["/configure.sh"]

CMD ["fy-computing.local"]

EXPOSE 25
