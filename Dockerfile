FROM php:8-apache
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN apt-get update && apt-get upgrade
RUN apt-get update -y 
RUN a2enmod headers
RUN a2enmod expires
RUN a2dissite 000-default.conf
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apt-get install -y nano

COPY ./_config/main.conf /etc/apache2/sites-enabled/main.conf
COPY ./_config/Blind-xss.conf /etc/apache2/sites-enabled/Blind-xss.conf
COPY ./_config/Blind-ssrf.conf /etc/apache2/sites-enabled/Blind-ssrf.conf

COPY ./php/index-ssrf.php /var/www/blindssrf/index.php
COPY ./php/index-xss.php /var/www/blindxss/index.php
COPY ./php/r.php /var/www/main/r.php


CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
EXPOSE 443
