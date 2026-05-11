# # FROM php:8.2-fpm

# # RUN apt-get update && apt-get install -y nginx \
# #     && docker-php-ext-install pdo_mysql

# # COPY . /var/www/html

# # WORKDIR /var/www/html

# # # ⬇️⬇️⬇️ السطرين الجديدين ⬇️⬇️⬇️
# # RUN apt-get install -y nodejs npm \
# #     && npm install \
# #     && npm run build
# # # ⬆️⬆️⬆️ ⬆️⬆️⬆️

# # # إعداد nginx الصحيح لمجلد public في Laravel
# # RUN echo "server {" > /etc/nginx/sites-available/default \
# #     && echo "    listen 80;" >> /etc/nginx/sites-available/default \
# #     && echo "    server_name _;" >> /etc/nginx/sites-available/default \
# #     && echo "    root /var/www/html/public;" >> /etc/nginx/sites-available/default \
# #     && echo "    index index.php;" >> /etc/nginx/sites-available/default \
# #     && echo "    location / {" >> /etc/nginx/sites-available/default \
# #     && echo "        try_files \$uri \$uri/ /index.php?\$query_string;" >> /etc/nginx/sites-available/default \
# #     && echo "    }" >> /etc/nginx/sites-available/default \
# #     && echo "    location ~ \.php\$ {" >> /etc/nginx/sites-available/default \
# #     && echo "        include snippets/fastcgi-php.conf;" >> /etc/nginx/sites-available/default \
# #     && echo "        fastcgi_pass 127.0.0.1:9000;" >> /etc/nginx/sites-available/default \
# #     && echo "    }" >> /etc/nginx/sites-available/default \
# #     && echo "}" >> /etc/nginx/sites-available/default

# # RUN chmod -R 775 /var/www/html/storage \
# #     && chmod -R 775 /var/www/html/bootstrap/cache \
# #     && chown -R www-data:www-data /var/www/html/storage \
# #     && chown -R www-data:www-data /var/www/html/bootstrap/cache

# # CMD service nginx start && php-fpm



#  FROM php:8.2-fpm

# RUN apt-get update && apt-get install -y \
#     nginx \
#     nodejs \
#     npm \
#     libicu-dev \
#     && docker-php-ext-install pdo_mysql intl

# COPY . /var/www/html

# WORKDIR /var/www/html

# RUN npm install && npm run build

# # إعداد nginx
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

# تحديث الحزم وتثبيت المتطلبات الأساسية
RUN apt-get update && apt-get install -y \
    curl \
    nginx \
    libicu-dev \
    # تثبيت Node.js و NPM من المصدر الرسمي (للحصول على نسخة حديثة مثل v20)
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && docker-php-ext-install pdo_mysql intl

# نسخ ملفات المشروع
COPY . /var/www/html

# تحديد مجلد العمل
WORKDIR /var/www/html

# تثبيت حزم Node وبناء الملفات
RUN npm install && npm run build

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
    && echo "    location ~* \.(css|js|jpg|jpeg|png|gif|ico|svg|woff|woff2|ttf|eot)$ {" >> /etc/nginx/sites-available/default \
    && echo "        expires max;" >> /etc/nginx/sites-available/default \
    && echo "        log_not_found off;" >> /etc/nginx/sites-available/default \
    && echo "        access_log off;" >> /etc/nginx/sites-available/default \
    && echo "        add_header Cache-Control \"public, immutable\";" >> /etc/nginx/sites-available/default \
    && echo "    }" >> /etc/nginx/sites-available/default \
    && echo "}" >> /etc/nginx/sites-available/default
    
# # إعداد Nginx
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

# ✅ إصلاح الصلاحيات (هذا هو الجزء الأهم)
# منح ملكية المجلدات لمستخدم www-data
RUN chown -R www-data:www-data /var/www/html/storage \
    && chown -R www-data:www-data /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html/public


# ⬇️⬇️⬇️ الأوامر الجديدة ⬇️⬇️⬇️
RUN php artisan route:clear
RUN php artisan config:clear
RUN php artisan view:clear
RUN php artisan cache:clear
RUN php artisan optimize
# ⬆️⬆️⬆️ ⬆️⬆️⬆️

CMD service nginx start && php-fpm
