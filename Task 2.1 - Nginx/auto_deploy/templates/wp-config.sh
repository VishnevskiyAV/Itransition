#!/bin/bash
wp config create --dbname=wordpress --dbuser=wordpress --dbpass=wordpress --dbhost=localhost --path=/var/www/html --allow-root --extra-php <<PHP
define( 'FS_METHOD', 'direct' );
define( 'WP_MEMORY_LIMIT', '128M' );
PHP
