#!/bin/bash
# build monika on OVH3 or local

set -xe
git co master
git pull
composer.phar install
drush cr || :
drush updb -y
drush cr || :
[ $(uname) == Linux ] && drush cim -y sync || drush cim -y sync --partial
drush cr
drush cc views
$(dirname "$0")/db-dump.sh
