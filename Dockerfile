FROM php:8.0-apache

COPY uploads.ini /usr/local/etc/php/conf.d/
RUN apt-get update -y
RUN apt-get -y install libenchant-2-dev
RUN apt-get -y install gcc make autoconf libc-dev pkg-config libzip-dev
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install calendar
RUN docker-php-ext-install exif
RUN docker-php-ext-install gettext
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
# RUN apt-get install -y php-pdo-mysql
# RUN apt-get install php8-mysql

RUN apt-get install -y --no-install-recommends \
	git \
	libmemcached-dev \
	libz-dev \
	libpq-dev \
	libssl-dev libssl-doc libsasl2-dev \
	libmcrypt-dev \
	libxml2-dev \
	zlib1g-dev libicu-dev g++ \
	libldap2-dev libbz2-dev \
	curl libcurl4-openssl-dev \
	libgmp-dev firebird-dev libib-util \
	re2c libpng++-dev \
	libwebp-dev libjpeg-dev libjpeg62-turbo-dev libpng-dev libxpm-dev libvpx-dev libfreetype6-dev \
	libmagick++-dev \
	libmagickwand-dev \
	zlib1g-dev libgd-dev \
	libtidy-dev libxslt1-dev libmagic-dev libexif-dev file \
	sqlite3 libsqlite3-dev libxslt-dev \
	libmhash2 libmhash-dev libc-client-dev libkrb5-dev libssh2-1-dev \
	unzip libpcre3 libpcre3-dev \
	poppler-utils ghostscript libmagickwand-6.q16-dev libsnmp-dev libedit-dev libreadline6-dev libsodium-dev \
	freetds-bin freetds-dev freetds-common libct4 libsybdb5 tdsodbc libreadline-dev librecode-dev libpspell-dev libonig-dev \
	cron

RUN ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
	docker-php-ext-install imap iconv

RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/
RUN docker-php-ext-install bcmath bz2 calendar ctype curl dba dom gd
RUN docker-php-ext-install fileinfo exif ftp gettext gmp
RUN docker-php-ext-install intl 
# RUN docker-php-ext-install json
RUN docker-php-ext-install ldap
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install opcache pcntl pspell
RUN docker-php-ext-install pdo pdo_dblib pdo_mysql pdo_pgsql pdo_sqlite pgsql phar posix
RUN docker-php-ext-install session shmop simplexml soap sockets sodium
RUN docker-php-ext-install sysvmsg sysvsem sysvshm

RUN export CFLAGS="-I/usr/src/php" && docker-php-ext-install xmlreader
RUN export CFLAGS="-I/usr/src/php" && docker-php-ext-install xmlwriter 
RUN export CFLAGS="-I/usr/src/php" && docker-php-ext-install xml 
# RUN export CFLAGS="-I/usr/src/php" && docker-php-ext-install xmlrpc 
RUN export CFLAGS="-I/usr/src/php" && docker-php-ext-install xsl

RUN docker-php-ext-install tidy 
RUN docker-php-ext-install tokenizer 
# RUN docker-php-ext-install zend_test 
RUN docker-php-ext-install zip

RUN pecl install ds 
RUN	pecl install imagick 
RUN	pecl install igbinary 
RUN	pecl install memcached 
# RUN	pecl install redis-5.1.0 
# RUN	pecl install mcrypt-1.0.3 
RUN	docker-php-ext-enable ds imagick igbinary memcached

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN a2enmod rewrite
RUN a2enmod headers