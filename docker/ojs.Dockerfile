FROM php:8.3-apache-bookworm

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		libcurl4-openssl-dev \
		libfreetype6-dev \
		libicu-dev \
		libjpeg62-turbo-dev \
		libonig-dev \
		libpng-dev \
		libxml2-dev \
		libxslt1-dev \
		libzip-dev \
		unzip; \
	docker-php-ext-configure gd --with-freetype --with-jpeg; \
	docker-php-ext-install -j"$(nproc)" \
		bcmath \
		curl \
		exif \
		ftp \
		gd \
		intl \
		mbstring \
		mysqli \
		opcache \
		pdo_mysql \
		xsl \
		zip; \
	a2enmod rewrite headers remoteip expires deflate; \
	rm -rf /var/lib/apt/lists/*

COPY docker/apache-ojs.conf /etc/apache2/conf-available/ojs-hardening.conf
COPY docker/php-production.ini /usr/local/etc/php/conf.d/zz-ojs-production.ini
COPY bin/ojs-scheduler.sh /usr/local/bin/ojs-scheduler.sh
COPY src/ /var/www/html/

RUN set -eux; \
	mkdir -p /var/www/html/cache /var/www/html/public /var/www/files; \
	chown -R www-data:www-data /var/www/html/cache /var/www/html/public /var/www/files; \
	find /var/www/html -type d -exec chmod 755 {} \;; \
	find /var/www/html -type f -exec chmod 644 {} \;; \
	chmod 755 /usr/local/bin/ojs-scheduler.sh; \
	a2enconf ojs-hardening

HEALTHCHECK --interval=30s --timeout=5s --retries=10 CMD curl -fsS -H 'Host: journal.atu.kz' -H 'X-Forwarded-Proto: https' http://127.0.0.1/index.php/index/index >/dev/null || exit 1
