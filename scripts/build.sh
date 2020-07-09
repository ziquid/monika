#!/bin/bash
# build monika on OVH3 or local

set -xe
git co master
git pull
composer.phar install
drush updb -y
drush cr || :
[ $(uname) == Linux ] && drush cim -y sync || drush cim -y sync --partial
drush cr
drush cc views
# [ $(uname) == Linux ] && drush pmu -y stage_file_proxy
# [ $(uname) == Linux ] && $(dirname "$0")/db-dump.sh
