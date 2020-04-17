FROM fireflyiii/tools-base-image:latest-amd64
# To learn more about this base image, visit https://github.com/firefly-iii/tools-base-image

ARG RELEASE=develop
ENV HOMEPATH=/var/www/html COMPOSER_ALLOW_SUPERUSER=1
LABEL version="1.0" maintainer="noone"

COPY scripts/site.conf /etc/apache2/sites-available/000-default.conf

# install Firefly III CSV Importer and patch configuration
WORKDIR $HOMEPATH

RUN apt-get update

RUN	apt-get install git

RUN	git clone https://github.com/bnw/firefly-iii-fints-importer.git

RUN	cd firefly-iii-fints-importer
	composer install

# Expose port 80
EXPOSE 5085

ADD scripts/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Run entrypoint thing
ENTRYPOINT ["/entrypoint.sh"]