#!/bin/bash
set -e

exec chmod a+rwx /var/www/files

if [ ! -z "$NGINX_AUTH_BASIC" ]; then
  # create .htpasswd file
  echo $NGINX_AUTH_BASIC |tr , '\n' > /etc/nginx/.htpasswd

  # update nginx config
  sed -i "s/# _auth_basic_/auth_basic \"Restricted\"; auth_basic_user_file \/etc\/nginx\/.htpasswd;/" \
    /etc/nginx/sites-available/default
fi
