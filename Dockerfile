FROM php:8-apache
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN apt-get update && apt-get upgrade
RUN apt-get update -y && apt-get install -y libpng-dev libjpeg-dev libpq-dev
RUN apt-get install -y php-curl
RUN a2enmod headers
RUN a2enmod expires
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apt-get install -y mc vim nano

COPY ./main.conf /etc/apache2/sites-enabaled/main.conf
COPY ./Blind-xss.conf /etc/apache2/sites-enabaled/Blind-xss.conf
COPY ./Blind-ssrf.conf /etc/apache2/sites-enabaled/Blind-ssrf.conf

COPY ./index-ssrf.php /var/www/blindssrf/index.php
COPY ./index-xss.php /var/www/blindxss/index.php
COPY ./r.php /var/www/main/r.php


CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
EXPOSE 443
