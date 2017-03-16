#!/bin/bash
oldServername="$( hostname )"
myNetworks="127.0.0.0/8 172.17.0.0/16 [::ffff:127.0.0.0/104] [::1/128]"
myHash="hash:/etc/postfix/virtual"

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

# Check for <hostname> argument
if [[ $1 ]]; then
	servername=$1
else
	servername=postfix
	hostname $servername
	if [[ -n "$( grep "$oldServername" /etc/hosts )" ]]; then
		sed -i "s/$oldServername/$servername/g" /etc/hosts
	fi
fi
#echo "Done setting up hostname!"

# Check for <maildomain> argument
if [[ $2 ]]; then
	maildomain=$1
else
	maildomain=example.com
fi

#echo $maildomain
postconf -e myhostname="$maildomain"
postconf -e mynetworks="$myNetworks"
postconf -e virtual_alias_maps="$myHash"

# Add addresses
if [[ -e /etc/postfix/virtual ]]; then
	continue
else
	touch /etc/postfix/virtual
fi
cat >> /etc/postfix/virtual<<EOF
root@$maildomain	root
contact@$maildomain	root
EOF

postmap /etc/postfix/virtual

#
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
