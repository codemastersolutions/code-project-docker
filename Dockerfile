FROM php:7.3.6-fpm-alpine3.9
MAINTAINER "Gilson Gabriel <gilson@codemastersolucoes.com>"

WORKDIR /var/www

RUN apk add --no-cache openssl bash mysql-client \
    && docker-php-ext-install pdo pdo_mysql \
    && curl -sS https://getcomposer.org/instaler | php -- --install-dir=/usr/local --filename=composer \
    && rm -rf /var/www/html

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

#COPY . /var/www

RUN ln -s publick html

EXPOSE 9000
ENTRYPOINT ["php-fpm"]
