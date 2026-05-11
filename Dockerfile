# FROM php:8.2-fpm

# RUN apt-get update && apt-get install -y nginx \
#     && docker-php-ext-install pdo_mysql

# COPY . /var/www/html

# WORKDIR /var/www/html

# # ⬇️⬇️⬇️ السطرين الجديدين ⬇️⬇️⬇️
# RUN apt-get install -y nodejs npm \
#     && npm install \
#     && npm run build
# # ⬆️⬆️⬆️ ⬆️⬆️⬆️

# # إعداد nginx الصحيح لمجلد public في Laravel
# RUN echo "server {" > /etc/nginx/sites-available/default \
#     && echo "    listen 80;" >> /etc/nginx/sites-available/default \
#     && echo "    server_name _;" >> /etc/nginx/sites-available/default \
#     && echo "    root /var/www/html/public;" >> /etc/nginx/sites-available/default \
#     && echo "    index index.php;" >> /etc/nginx/sites-available/default \
#     && echo "    location / {" >> /etc/nginx/sites-available/default \
#     && echo "        try_files \$uri \$uri/ /index.php?\$query_string;" >> /etc/nginx/sites-available/default \
#     && echo "    }" >> /etc/nginx/sites-available/default \
#     && echo "    location ~ \.php\$ {" >> /etc/nginx/sites-available/default \
#     && echo "        include snippets/fastcgi-php.conf;" >> /etc/nginx/sites-available/default \
#     && echo "        fastcgi_pass 127.0.0.1:9000;" >> /etc/nginx/sites-available/default \
#     && echo "    }" >> /etc/nginx/sites-available/default \
#     && echo "}" >> /etc/nginx/sites-available/default

# RUN chmod -R 775 /var/www/html/storage \
#     && chmod -R 775 /var/www/html/bootstrap/cache \
#     && chown -R www-data:www-data /var/www/html/storage \
#     && chown -R www-data:www-data /var/www/html/bootstrap/cache

# CMD service nginx start && php-fpm



 FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    nginx \
    nodejs \
    npm \
    libicu-dev \
    && docker-php-ext-install pdo_mysql intl

COPY . /var/www/html

WORKDIR /var/www/html

RUN npm install && npm run build

# إعداد nginx
RUN echo "server {" > /etc/nginx/sites-available/default \
    && echo "    listen 80;" >> /etc/nginx/sites-available/default \
    && echo "    server_name _;" >> /etc/nginx/sites-available/default \
    && echo "    root /var/www/html/public;" >> /etc/nginx/sites-available/default \
    && echo "    index index.php;" >> /etc/nginx/sites-available/default \
    && echo "    location / {" >> /etc/nginx/sites-available/default \
    && echo "        try_files \$uri \$uri/ /index.php?\$query_string;" >> /etc/nginx/sites-available/default \
    && echo "    }" >> /etc/nginx/sites-available/default \
    && echo "    location ~ \.php\$ {" >> /etc/nginx/sites-available/default \
    && echo "        include snippets/fastcgi-php.conf;" >> /etc/nginx/sites-available/default \
    && echo "        fastcgi_pass 127.0.0.1:9000;" >> /etc/nginx/sites-available/default \
    && echo "    }" >> /etc/nginx/sites-available/default \
    && echo "}" >> /etc/nginx/sites-available/default

RUN chmod -R 775 /var/www/html/storage \
    && chmod -R 775 /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html/storage \
    && chown -R www-data:www-data /var/www/html/bootstrap/cache

CMD service nginx start && php-fpm
