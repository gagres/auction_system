#!/bin/sh

# Install back-end dependencies
composer install

# Install front-end dependencies
npm install
npm run build

# Laravel application config
php artisan cache:clear
php artisan config:clear
php artisan config:cache

# Migratete
php artisan migrate

# Set permissions
chmod 777 -R storage/logs
chmod 777 -R storage/framework/

/usr/bin/supervisord -n -c /etc/supervisord.conf
