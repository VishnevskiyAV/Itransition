<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wordpress' );

/** Database password */
define( 'DB_PASSWORD', 'wordpress' );
define('FS_METHOD', 'direct');
/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define('FORCE_SSL_ADMIN', true);
if (strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false)
    $_SERVER['HTTPS']='on';

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          'G/!5kFlV[j2/:$*!mW0RcT(7uCNGiFJ.N}A=KKe/@`Ltbr`<t&lUm37fkvI>9F]]' );
define( 'SECURE_AUTH_KEY',   '-iq({}>|!]p!z 6)3^Gyn5_+*MBRcvW8:`*B,_a:}=i%Bu~8;NUp(zmOl>}D:e#B' );
define( 'LOGGED_IN_KEY',     'Fj6a[hPsE<)Aqi+mTU1E76c?mcXdI_GYSM#gN5#^ck7KYhCX~sAT7LNR4W7=51,)' );
define( 'NONCE_KEY',         '(,#yCC0m<x/wr1Ixqmph%m`Y*OZqnl6UoBK/%Klb=YwLQok!IwI^<PsFmL|~qE} ' );
define( 'AUTH_SALT',         'h:JrNL%8cE)uaf7r0@Ol1GvI~x=lD.F!Bg%Oz;3MaNb)Al*Vf/o9EQr.X|7V0j(l' );
define( 'SECURE_AUTH_SALT',  '017!8E.&u6-Klj=h8::;flZDWg$qfap :.e?WOPj)O::iIp;LNSGiOo)>@_5N A?' );
define( 'LOGGED_IN_SALT',    '7g%fe(C1_SCii)E<Bh+kM>{P5N[.!$j.A)yfEL1dkMu_EW@kxW#uT_f55r 6fVAr' );
define( 'NONCE_SALT',        'OT*XNVb0V]rYp.S:Z-Rpi j5E3E1ClG9rn5(@Ig;4e]|:h20p>8tLP5dzCJ?D*K-' );
define( 'WP_CACHE_KEY_SALT', 'c7,I+CT }/`S*%=@aXL%!O(r.sgF=vMfOat!)36[,]Y(n_s?Z!v t<B+0TAEJ]*C' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/* Add any custom values between this line and the "stop editing" line. */

define( 'WP_MEMORY_LIMIT', '128M' );

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
