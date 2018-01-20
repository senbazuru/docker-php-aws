FROM circleci/php:7.1-cli-browsers
MAINTAINER senbazuru

RUN curl -sL bootstrap.pypa.io/get-pip.py | sudo python \
    && sudo pip install awscli

RUN deps='\
         ruby \
         libpng-dev \
         libmagickwand-dev \
         libpq-dev \
         ' \
     && set -x \
     && sudo apt update -qq \
     && sudo apt install -y -qq $deps --no-install-recommends \
     && sudo gem install bundler \
     && sudo rm -rf /var/lib/apt/lists/* \
     && sudo docker-php-ext-install gd pgsql \
     && yes | sudo pecl install imagick \
     && sudo docker-php-ext-enable imagick \
     && curl -sL github.com/websupport-sk/pecl-memcache/archive/NON_BLOCKING_IO_php7.tar.gz | tar xz -C /tmp \
     && cd /tmp/pecl-memcache-NON_BLOCKING_IO_php7 \
     && phpize \
     && ./configure --enable-memcache --with-php-config=/usr/local/bin/php-config \
     && make \
     && sudo cp modules/memcache.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303 \
     && sudo docker-php-ext-enable memcache \
     && rm -rf /tmp/pecl-memcache-NON_BLOCKING_IO_php7
