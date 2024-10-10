
FROM ubuntu:20.04


ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    nginx \
    php-fpm \
    php-cli \
    php-pear \
    php-dev \
    php-mysql \
    php-zip \
    php-xml \
    php-mbstring \
    zip \
    libcurl3-dev \ 
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    openssl \
    libssl-dev \
    libcurl4-openssl-dev \
    # libaio1 \ 
    # libapache2-mod-php \
    # libcgi-fast-perl \
    # libcgi-pm-perl \
    # libencode-locale-perl \
    # libevent-core-2.1-7 \
    # libfcgi-perl \
    # libhtml-parser-perl \
    # libhtml-tagset-perl \
    # libhtml-template-perl \
    # libhttp-date-perl \
    # libhttp-message-perl \
    # libio-html-perl \
    # liblwp-mediatypes-perl \
    # libnuma1 \
    # liburi-perl \
    curl \
    gnupg \
    unzip \
    git \         
    build-essential \
    && rm -rf /var/lib/apt/lists/*



RUN pecl install mongodb
# RUN pecl install xdebug
# RUN docker-php-ext-enable xdebug

RUN echo "extension=mongodb.so" >> /etc/php/7.4/fpm/php.ini && \
    echo "extension=mongodb.so" >> /etc/php/7.4/cli/php.ini


COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./nginx/example.conf /etc/nginx/sites-available/example.conf



# COPY .default.conf /etc/nginx/sites-enabled/default.conf

WORKDIR /var/www/html


COPY ./src /var/www/html/


# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && cd /var/www/html/ \
    && composer install



RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html


EXPOSE 80


CMD service php7.4-fpm start && nginx -g 'daemon off;'

