FROM php:7.2-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql
RUN apk add --no-cache bash
RUN composer install
RUN npm install