#!/bin/bash
serverName="$( hostname )"
myNetworks="127.0.0.0/8 172.17.0.0/16 [::ffff:127.0.0.0/104] [::1/128]"
#myHash="hash:/etc/postfix/virtual"

#judgement
if [[ -a /etc/supervisor/conf.d/supervisord.conf ]]; then
  exit 0
fi

#supervisor
cat > /etc/supervisor/conf.d/supervisord.conf <<EOF
[supervisord]
nodaemon=true

[program:postfix]
command=service postfix start

[program:rsyslog]
command=/usr/sbin/rsyslogd -n -c3
EOF

# Check for <maildomain> argument
if [[ $1 ]]; then
	maildomain=$1
else
	maildomain=example.com
fi

#echo $maildomain
postconf -e myhostname="$serverName.$maildomain"
postconf -e mynetworks="$myNetworks"
postconf -e mydestination="$serverName.$maildomain, $maildomain, localhost, localhost.localdomain"
#postconf -e virtual_alias_maps="$myHash"

# Mapping virtual mail addresses
#if [[ -e /etc/postfix/virtual ]]; then
#	continue
#else
#	touch /etc/postfix/virtual
#fi
#cat >> /etc/postfix/virtual<<EOF
#root@$maildomain	root
#contact@$maildomain	root
#EOF

#postmap /etc/postfix/virtual

# Adding default aliases
cat > /etc/aliases<<EOF
mailer-daemon: postmaster
postmaster: root
nobody: root
hostmaster: root
usenet: root
news: root
webmaster: root
www: root
ftp: root
abuse: root
EOF

newaliases

# Starting supervisord to run Postfix mail system
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
