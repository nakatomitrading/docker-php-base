FROM php:8.3-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    nginx \
    supervisor \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    oniguruma-dev \
    icu-dev \
    postgresql-dev \
    libpq \
    nodejs \
    npm \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        gd \
        pdo_mysql \
        pdo_pgsql \
        mbstring \
        exif \
        pcntl \
        bcmath \
        zip \
        intl \
        opcache

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Default working directory for Laravel apps
WORKDIR /var/www/html

# Labels for image metadata
LABEL org.opencontainers.image.source="https://github.com/nakatomitrading/docker-php-base"
LABEL org.opencontainers.image.description="PHP 8.3 FPM Alpine base image with common Laravel extensions"
LABEL org.opencontainers.image.licenses="MIT"
