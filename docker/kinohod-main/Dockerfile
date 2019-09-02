FROM perl:5.20.3

ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
ENV TERM="screen"

## Preparation
ENV TERM=screen
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DE742AFA
RUN apt -yq update \
    && DEBIAN_FRONTEND=noninteractive apt -yq install wget tar postgresql-client-9.5 libpq-dev libssl-dev libjpeg-dev libcurl3-dev build-essential

## CPAN installation
RUN curl -L https://cpanmin.us/ -o /usr/local/bin/cpanm && chmod +x /usr/local/bin/cpanm

## Copying code
COPY . /usr/src/kinohod

## Install modules from CPAN
RUN cpanm -n IO::Socket::SSL App::cpm
RUN cpm install --no-test --global --cpanfile=/usr/src/kinohod/cpanfile



WORKDIR /usr/src/kinohod
