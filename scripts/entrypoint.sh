#!/bin/bash

echo "Now in entrypoint.sh (v0.0.1) for fints importer."
echo "Please wait for the container to start..."

# make sure the correct directories exists (suggested by @chrif):
mkdir -p $HOMEPATH/storage/app/public
mkdir -p $HOMEPATH/storage/build
mkdir -p $HOMEPATH/storage/database
mkdir -p $HOMEPATH/storage/debugbar
mkdir -p $HOMEPATH/storage/export
mkdir -p $HOMEPATH/storage/framework/cache/data
mkdir -p $HOMEPATH/storage/framework/sessions
mkdir -p $HOMEPATH/storage/framework/testing
mkdir -p $HOMEPATH/storage/framework/views/twig
mkdir -p $HOMEPATH/storage/framework/views/v1
mkdir -p $HOMEPATH/storage/framework/views/v2
mkdir -p $HOMEPATH/storage/logs
mkdir -p $HOMEPATH/storage/upload

echo "We got pretty far...."

# make sure we own the volumes:
chown -R www-data:www-data -R $HOMEPATH/storage
chmod -R 775 $HOMEPATH/storage

# remove any lingering files that may break upgrades:
rm -f $HOMEPATH/storage/logs/laravel.log

echo "Installing via composer"

cd firefly-iii-fints-importer
composer install

echo "Ready to start webserver on port 80"

php -S 0.0.0.0:80 app/index.php