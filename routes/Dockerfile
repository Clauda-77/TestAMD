
FROM php:8.2-fpm

# تثبيت ملحقات النظام و PHP المطلوبة
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nginx \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# تثبيت Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# إعداد مجلد العمل
WORKDIR /var/www/html

# نسخ ملفات المشروع (باستثناء ما هو مذكور في .dockerignore)
COPY . .

# تثبيت تبعيات Composer (بدون التطوير)
RUN composer install --no-dev --optimize-autoloader --no-interaction

# إعداد الجلسات والكاش باستخدام الملفات
RUN chmod -R 755 storage bootstrap/cache
RUN php artisan config:cache && php artisan route:cache
RUN php artisan view:cache

# إعداد Nginx للإشارة إلى مجلد public
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

EXPOSE 80
CMD service nginx start && php-fpm