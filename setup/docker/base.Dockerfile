FROM php:7.4-fpm-alpine

RUN apk add -Uuv \
    zlib-dev \
    freetype-dev \
    icu-dev \
    libjpeg-turbo-dev \
    libmcrypt-dev \
    postgresql-dev \
    libpng-dev \
    libvpx-dev \
    libxpm-dev \
    libzip-dev \
    oniguruma-dev \
    && rm -rf /var/cache/apk/*

# Install Redis necessary config
ENV PHPREDIS_VERSION 5.3.2
RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts

RUN docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-install -j$(nproc) exif \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install -j$(nproc) mbstring \
    && docker-php-ext-install -j$(nproc) opcache \
    && docker-php-ext-install -j$(nproc) pcntl \
    && docker-php-ext-install -j$(nproc) pdo \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && docker-php-ext-install -j$(nproc) posix \
    && docker-php-ext-install -j$(nproc) redis \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-install -j$(nproc) exif \
    && docker-php-ext-install -j$(nproc) sockets \
    && docker-php-ext-configure gd --with-freetype --with-jpeg

RUN apk --update --no-cache add \
    supervisor \
    nginx \
    curl \
    dpkg \
    bash

RUN mkdir -p /etc/nginx/conf.d \
    && mkdir -p /etc/nginx/sites-enabled \
    && mkdir -p /run/nginx /etc/supervisor.d/ \
    && rm /etc/nginx/conf.d/default.conf \
    && rm /usr/local/etc/php-fpm.d/*docker* \
    && rm /usr/local/etc/php-fpm.d/www.conf.default

# config NGINX
COPY config/etc/nginx /etc/nginx/

# config PHP-FPM
COPY config/usr/local/etc/ /usr/local/etc/

# config SUPERVISORD
COPY config/etc/supervisord.conf /etc/supervisord.conf
COPY config/etc/supervisor.d /etc/supervisor.d/

WORKDIR /var/www/html

EXPOSE 80

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
