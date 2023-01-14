#!/bin/bash
wp config create --dbname=wordpress --dbuser=wordpress --dbpass=wordpress --dbhost=localhost --path=/var/www/html --allow-root --extra-php <<PHP
define( 'FS_METHOD', 'direct' );
define( 'WP_MEMORY_LIMIT', '128M' );
define('FORCE_SSL_ADMIN', true);
if (strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false)
    $_SERVER['HTTPS']='on';

PHP
