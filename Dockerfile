FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    nginx \
    && docker-php-ext-install pdo_mysql

COPY . /var/www/html

WORKDIR /var/www/html

RUN chmod -R 755 storage bootstrap/cache

CMD service nginx start && php-fpm
