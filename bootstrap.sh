#! /bin/bash

if ! env | grep -q ^TEMPORARY_USER=
then
  echo "Bootstrapping..."

  export TEMPORARY_USER=$USER

  composer dump-autoload
  composer install

  php artisan down

  if [ ! -e .env ]
  then
    cp .env.example .env
    php artisan key:generate
    echo "Initialised the example environment file..."
  fi

  php artisan optimize

  sudo -Eu root bash -c 'find . -type d \( -path "./.git/*" -o -path "./vendor/*" -o -path "./node_modules/*" \) -prune -o \! -name .gitignore -exec chown -R $TEMPORARY_USER:www-data {} \;'
  sudo -Eu root bash -c 'find . -type d \( -path "./.git/*" -o -path "./vendor/*" -o -path "./node_modules/*" \) -prune -o -type d -exec chmod 755 {} \;'
  sudo -Eu root bash -c 'find . -type d \( -path "./.git/*" -o -path "./vendor/*" -o -path "./node_modules/*" \) -prune -o -type f ! -name .gitignore -exec chmod 644 {} \;'

  if [ ! -d bootstrap/cache ]
  then
     bootstrap/cache
  fi

  sudo -Eu root bash -c 'chmod 777 bootstrap/cache'
  sudo -Eu root bash -c 'chown $TEMPORARY_USER:www-data bootstrap/cache'

  sudo -Eu root bash -c 'find ./storage -type d -exec chmod 777 {} \;'
  sudo -Eu root bash -c 'find ./storage -type f ! -name .gitignore -exec chmod 644 {} \;'

  sudo -Eu root bash -c 'chmod 750 ./'
  sudo -Eu root bash -c 'chown $TEMPORARY_USER:www-data ./'

  unset TEMPORARY_USER

  php artisan up

  echo "Bootstrapping finished."
else
  echo "You have already exported the variable TEMPORARY_USER, which this script uses to set as the chown owner for permissions"
fi


