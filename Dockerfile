FROM circleci/php:7.1-cli-browsers
MAINTAINER senbazuru

RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "/tmp/get-pip.py"
RUN sudo python /tmp/get-pip.py
RUN sudo pip install awscli
