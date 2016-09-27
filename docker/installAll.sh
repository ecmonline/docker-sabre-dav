#!/usr/bin/env bash
cd /
locale-gen en_US.UTF-8

add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install nginx php5-fpm php5-cli

sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php5/fpm/php.ini && \
  sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php5/cli/php.ini && \
  sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf && \
  sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini && \
  sed -i "s/;listen.owner = www-data/listen.owner = www-data/" /etc/php5/fpm/pool.d/www.conf && \
  sed -i "s/;listen.group = www-data/listen.group = www-data/" /etc/php5/fpm/pool.d/www.conf && \
  sed -i "s/;listen.mode = 0660/listen.mode = 0660/" /etc/php5/fpm/pool.d/www.conf

curl -sS https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer

cd /var/www
composer require sabre/dav ~2.0.5
cd /

chown www-data:www-data /var/www/server.php && \
  mkdir -p    /var/www/data && \
  chmod a+rwx /var/www/data && \
  mkdir -p /var/www/files

chmod +x /etc/my_init.d/*.sh

echo "daemon off;" >> /etc/nginx/nginx.conf

apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
