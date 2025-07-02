#!/bin/sh

if [ -n "$MAILGUN_LOGIN" ]; then
  sed -i "s/PASS_VIA_ENV/$MAILGUN_LOGIN/" /etc/postfix/main.cf
elif [ -s "$MAILGUN_LOGIN_FILE" ]; then
  sed -i "s/PASS_VIA_ENV/$(cat $MAILGUN_LOGIN_FILE)/" /etc/postfix/main.cf
else
  echo Please specify MAILGUN_LOGIN or provide a file via MAILGUN_LOGIN_FILE >&2
  exit 1
fi

exec postfix start-fg
