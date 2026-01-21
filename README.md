# PHP Laravel Base Image

Pre-built PHP 8.3 FPM Alpine image with all common Laravel extensions compiled.

## Usage

```dockerfile
FROM ghcr.io/nakatomitrading/docker/laravel-83:latest

COPY . .
RUN composer install --no-dev --optimize-autoloader
RUN npm install && npm run build

# Add your nginx/supervisor configs
COPY docker/nginx.conf /etc/nginx/http.d/default.conf
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
```

## What's Included

**PHP Extensions:**
- gd (with freetype, jpeg)
- pdo_mysql
- pdo_pgsql
- mbstring
- exif
- pcntl
- bcmath
- zip
- intl
- opcache

**Tools:**
- Composer (latest)
- Node.js + npm
- nginx
- supervisor
- git

## Tags

- `latest` - Most recent build
- `YYYYMMDD` - Dated builds (e.g., `20260121`)
- `8.3.x-YYYYMMDD` - Full PHP version + date (e.g., `8.3.15-20260121`)

Use dated tags to pin a known-good version.

## Auto-rebuild

This image automatically rebuilds when:
- Code is pushed to main
- The base `php:8.3-fpm-alpine` image is updated (checked weekly)
- Manually triggered via workflow dispatch

The workflow compares the base image digest to avoid unnecessary rebuilds.

## Why?

Compiling PHP extensions on Alpine takes 2-3 minutes. With this base image, app builds drop to ~30 seconds (just composer install + npm build).
