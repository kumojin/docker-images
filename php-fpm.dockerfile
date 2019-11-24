FROM php:7.2-fpm

RUN apt-get update \
  && apt-get -y install libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev libfreetype6-dev \
                        zlib1g-dev libjpeg-dev \
  && rm -rf /var/lib/apt/lists/*

RUN set -ex \
  && docker-php-source extract \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/  \
  && docker-php-ext-install mysqli opcache gd \
  && pecl install -o -f redis \
  &&  rm -rf /tmp/pear \
  &&  docker-php-ext-enable redis \
  && docker-php-source delete \
  && usermod -u 101 www-data
