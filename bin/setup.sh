#!/bin/bash

if [ -f "./wordpress/wp-config.php" ];
then
	echo "WordPress config file found."
else
	echo "WordPress config file not found. Installing..."
	export XDEBUG_HOST=$(ipconfig getifaddr en0) # Specific to Macintosh
	docker-compose exec --user www-data phpfpm wp core download
	docker-compose exec --user www-data phpfpm wp core config --dbhost=mariadb --dbname=wordpress --dbuser=root --dbpass=password
	docker-compose exec --user www-data phpfpm wp core install --url=localhost  --title="WordPress Development" --admin_user=admin --admin_password=password --admin_email=info@example.com
	docker-compose exec --user www-data phpfpm wp plugin update --all
	docker-compose exec --user www-data phpfpm wp plugin install any-ipsum debug-bar wp-inspect heartbeat-control query-monitor whats-running debug-bar-remote-requests wordpress-php-info
fi