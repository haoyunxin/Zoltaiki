FROM php:8.2.17-fpm-alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk update && \
    apk add zip libzip-dev libpng-dev zlib-dev autoconf build-base libevent-dev gcc libc-dev libwebp-dev libjpeg-turbo-dev jpeg-dev freetype-dev make g++ rabbitmq-c-dev libsodium-dev libmcrypt-dev gmp-dev libpq-dev libmemcached-dev ca-certificates openssl-dev tzdata --no-cache && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone && apk del tzdata && \
    update-ca-certificates && \
    docker-php-ext-configure gd --with-jpeg --with-freetype --with-webp && \
    docker-php-ext-install gd sockets pcntl pdo_mysql mysqli gmp zip bcmath redis amqp mongodb pdo_pgsql pgsql && \
    pecl install redis && \
    pecl install amqp && \
    pecl install mongodb && \
    pecl install event && \
    docker-php-ext-enable redis amqp mongodb event && \
    curl -sS https://getcomposer.org/installer | php && \
	mv ./composer.phar /usr/bin/composer && \
	composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

VOLUME /var/www
WORKDIR /var/www
