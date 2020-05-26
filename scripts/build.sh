#!/bin/bash
# build monika on OVH3 or local

set -xe
git co master
git pull
composer.phar install
drush updb -y
drush cim -y sync
drush cr
drush cc views
