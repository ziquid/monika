#!/bin/bash
# build monika on OVH3 or local

set -xe

# Linux/non-apache?  sudo to apache
[ $(uname) == Linux ] && [ $(whoami) == apache ] && exec sudo su -l apache -s /bin/bash "$0" "$@"

cd $(dirname "$0")/..
git fetch

if [ "$1" != "" ]; then
  echo checking out branch $1...
  git co $1
  git pull
fi

composer.phar install
drush cr || :
drush updb -y
drush cr || :
[ $(uname) == Linux ] && drush cim -y sync || drush cim -y sync --partial
drush cr
drush cc views
scripts/db-dump.sh
