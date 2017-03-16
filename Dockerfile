FROM sameersbn/ubuntu:14.04.20170123
MAINTAINER ELOUIZ BADR <elouiz.badr@gmail.com>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y supervisor postfix nano mailutils telnet

RUN apt-get clean && apt-get autoclean

COPY assets/configure.sh /

ENTRYPOINT ["/configure.sh"]

CMD ["mailserver", "fy-computing.local"]

EXPOSE 25
