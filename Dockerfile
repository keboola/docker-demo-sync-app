FROM php:7

WORKDIR /code

COPY . /code/

RUN apt-get update && apt-get install -y \
        git \
        unzip \
   --no-install-recommends && rm -r /var/lib/apt/lists/*

RUN mv /code/php.ini /usr/local/etc/php/php.ini

CMD php /code/src/run.php --data=/data
