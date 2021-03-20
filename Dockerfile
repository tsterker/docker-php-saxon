# inspiration:
# - https://github.com/rastu/dockerfiles/blob/master/saxon/php-fpm/5.6.25/Dockerfile
# - https://saxonica.plan.io/issues/3117
FROM php:7.4

ENV LIBSAXON_BINARY libsaxon-PEC-setup64-v1.2.1
ENV SAXONC_HOME /usr/lib

# Install dependencies via German mirror
RUN echo "deb http://ftp2.de.debian.org/debian buster main" > /etc/apt/sources.list
RUN apt-get update && apt-get install -y lib32z1 gcc-multilib unzip man

# Install JDK (Bug with missing man directory: https://github.com/geerlingguy/ansible-role-java/issues/64#issuecomment-393299088)
RUN mkdir -p /usr/share/man/man1
RUN apt-get install -y default-jdk

#PREPARE SAXON INSTALLATION (https://www.saxonica.com/saxon-c/documentation/index.html#!starting/installing/installingLinux)
COPY $LIBSAXON_BINARY /$LIBSAXON_BINARY
RUN yes "/Saxonica" | ./$LIBSAXON_BINARY

#PREPARE ENVIRONMENT
RUN cp /Saxonica/libsaxonpec.so /usr/lib/ \
    && cp -r /Saxonica/rt /usr/lib/rt

#PHPIZE
RUN cd /Saxonica/Saxon.C.API \
    && phpize \
    && ./configure --enable-saxon \
    && make -j$(nproc) \
    && make install

#ENABLE SAXON PHP EXT
RUN docker-php-ext-enable saxon

#CLEANUP
RUN rm -rf /Saxonica /install-libsaxon-setup.sh /$LIBSAXON_BINARY \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
