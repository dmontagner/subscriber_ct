FROM ubuntu:xenial
MAINTAINER Diogo Montagner <dmontagner@juniper.net>

ADD     apt/sources.list /etc/apt/sources.list
ADD     apt/apt.conf /etc/apt/apt.conf

RUN     apt-get -y update --allow-unauthenticated && \
        apt-get -y upgrade --allow-unauthenticated && \
        apt-get clean   &&\
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN     apt-get -y update --allow-unauthenticated && \
        apt-get -y install --allow-unauthenticated \
            ppp \
            net-tools \
            xfsprogs \
            pppoe && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#####################################
###   Subscribers configuration   ###
#####################################

ADD     subscribers/subscriber /etc/ppp/peers/subscriber

WORKDIR /
ENV HOME /root

#CMD ["/sbin/my_init"]
