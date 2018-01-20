FROM circleci/php:7.1-cli-browsers
MAINTAINER senbazuru

RUN curl -sL bootstrap.pypa.io/get-pip.py | sudo python \
    && sudo pip install awscli
