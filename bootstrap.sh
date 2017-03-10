#! /bin/bash

echo "Bootstrapping..."

export LARAVEL_USER=$USER

sudo -Eu root bash -c 'find . ! -name .gitignore -exec chown -R $LARAVEL_USER:www-data {} \;'
sudo -Eu root bash -c 'find . -type d -exec chmod 755 {} \;'
sudo -Eu root bash -c 'find . -type f ! -name .gitignore -exec chmod 644 {} \;'

if [ ! -d bootstrap/cache ]
then
    mkdir bootstrap/cache
fi

sudo -Eu root bash -c 'chmod 2775 bootstrap/cache'
sudo -Eu root bash -c 'chown $LARAVEL_USER:www-data bootstrap/cache'

sudo -Eu root bash -c 'find storage -type d -exec chmod 777 {} \;'
sudo -Eu root bash -c 'find storage -type f ! -name .gitignore -exec chmod 644 {} \;'

if [ ! -e .env ]
then
    cp .env.example .env
    echo "Initialised the example environment file..."
fi

sudo -Eu root bash -c 'chmod 750 ./'
sudo -Eu root bash -c 'chown $LARAVEL_USER:www-data ./'
sudo -Eu root bash -c 'chmod +x permissions.sh'

composer dumpautoload
composer install
php artisan down
php artisan optimize
php artisan up

echo "Bootstrapping finished."

