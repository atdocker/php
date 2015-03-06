FROM atdocker/nginx:latest

RUN apt-get update; \
    apt-get install -y libmysqlclient18 mysql-common libdbd-mysql-perl libmysqlclient-dev libxslt1-dev; \
    apt-get install -y libjpeg-dev libpng-dev libxpm-dev libfreetype6-dev libc-client-dev; \

    # ---------------------
    # Install PHP 5.5
    # ---------------------
    mkdir -p mkdir -p /opt/php55; \
    cd /opt/php55; \
    wget http://sg3.php.net/distributions/php-5.5.22.tar.gz; \
    tar zxf php-5.5.22.tar.gz; \
    rm -f *.gz; \
    mv /opt/php55/php-5.5.22 /opt/php55/src; \
    cd /opt/php55/src; \
    ./configure \
        --enable-bcmath \
        --enable-calendar \
        --enable-exif \
        --enable-fpm \
        --enable-ftp \
        --enable-gd-native-ttf \
        --enable-mbstring \
        --enable-opcache \
        --enable-pcntl \
        --enable-soap \
        --enable-zip \
        --prefix=/opt/php55 \
        --with-curl \
        --with-fpm-group=www-data \
        --with-fpm-user=www-data \
        --with-freetype-dir=/usr \
        --with-gd \
        --with-imap-ssl \
        --with-imap \
        --with-jpeg-dir=/usr \
        --with-kerberos \
        --with-mcrypt \
        --with-mysql-sock=/var/run/mysqld/mysqld.sock \
        --with-mysql \
        --with-mysqli=/usr/bin/mysql_config \
        --with-openssl \
        --with-pdo-mysql \
        --with-pear \
        --with-png-dir=/usr \
        --with-xmlrpc \
        --with-xpm-dir=/usr \
        --with-xsl \
        --with-zlib; \
    make && make install; \
    ln -s /opt/php55/bin/php /usr/local/bin/php; \
    mkdir -p /var/log/php/; \
    touch /var/log/php/php55-fpm-error.log; \
    ln -s /opt/php55/bin/php /usr/local/bin/php; \

    # ---------------------; \
    # Install composer     ; \
    # ---------------------; \
    curl -sS https://getcomposer.org/installer | php; \
    chmod a+x composer.phar; \
    mv composer.phar /usr/local/bin/composer;

ADD ./etc/init.d/php55-fpm.bash /etc/init.d/php55-fpm
ADD ./etc/fpm/fpm-pool-common.conf /opt/etc/fpm/fpm-pool-common.conf
ADD ./etc/php55-fpm.conf /opt/php55/etc/php55-fpm.conf
ADD ./etc/pool.d/www-data.conf /opt/php55/etc/pool.d/www-data.conf
