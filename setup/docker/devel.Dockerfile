FROM gagres/auction:app-base

RUN apk --update --no-cache add composer git npm

RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && pecl install xdebug-2.9.8 \
    && docker-php-ext-enable xdebug \
    && apk del -f .build-deps

COPY setup/docker/config/etc/xdebug/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# config xdebug files
RUN mkdir -p /var/log && \
    touch /var/log/xdebug.log && \
    chown www-data:www-data /var/log/xdebug.log && \
    chmod 664 /var/log/xdebug.log

USER root
