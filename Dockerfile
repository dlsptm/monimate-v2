ARG PHP_VERSION=8.4

FROM php:${PHP_VERSION}-fpm

RUN apt-get update && apt-get install -y \
        curl \
        bash \
        git \
        libzip-dev \
        unzip \
        libonig-dev \
        libcurl4-openssl-dev \
        libicu-dev \
        autoconf \
        gcc \
        g++ \
        make \
        libpq-dev \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && docker-php-ext-install -j$(nproc) intl pdo pdo_pgsql pgsql zip opcache bcmath sockets \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apt-get purge -y --auto-remove autoconf gcc g++ make \
    && rm -rf /var/lib/apt/lists/*


COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY composer.json composer.lock ./

COPY . .

RUN composer install --optimize-autoloader --no-interaction

RUN curl -sS https://get.symfony.com/cli/installer | bash

# Make sure symfony CLI is in the PATH
ENV PATH="/root/.symfony5/bin:${PATH}"

# Use exec form for CMD and remove invalid flags
CMD ["bash", "-c", "composer install && npm install && symfony serve --allow-http --no-tls --port=8000 --listen-ip=0.0.0.0"]
