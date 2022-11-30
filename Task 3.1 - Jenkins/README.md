## Jenkins
Use automatic deployment of Jenkins docker image to AWS ECS environment.
./terraform-ecs-jenkins

```
terraform init
terraform plan
terraform apply

```
Connect to ECS EC2 instance to pull logs from Jenkins container to get administrator key

```
docker logs <conteiner_id>

```
We use EFS volume to attach to Jenkins conteiner to store all settings (it must be created independently of this template)host
Also we use docker.sock from the host EC2 instance (it's not safe, but for this task it's ok)

## Project
```
# Using java project with docker build and deploying to AWS ECS with docker compose file. When deployed it will be "Hello world" string in the browser. 

https://github.com/VishnevskiyAV/java-app.git

#Jenkins file with pipeline inside the project
# To connect to Git Repository we use SSH autentification
# There are two branches main and staging
# The artifact is docker container it stores in docker hub (connection via username and token)

```
<img src="./images/first_task.png"><br>

## Изменение конфигурации nginx
```
# Create new configuration for nginx
cd /etc/nginx/sites-available/
cp default nginx80

# Change nginx80 to listen new ports and in new dir and create symlink
sudo ln -s /etc/nginx/sites-available/nginx80 /etc/nginx/sites-enabled/nginx80
sudo systemctl restart nginx

# So now nginx is responding to us on both ports 80 and 8080.
# To avoid memory problems
sudo nano /etc/nginx/nginx.conf
activate server_names_hash_bucket_size 64;
```
<img src="./images/nginx_on_both_ports.png"><br>

```
# Configure nginx:80 to reverse proxy
Use config file (dir: nginx-conf/nginx80)

# Configure logging on backend server
Use config file (dir: nginx-conf/nginx80)

```

## Installing Wordpress
```
# Creating a MySQL Database and a WordPress User
sudo mysql -u root -p
mysql> CREATE DATABASE wordpress;
mysql> CREATE USER wordpress@localhost IDENTIFIED BY 'wordpress';
mysql> GRANT ALL PRIVILEGES ON wordpress.* TO wordpress@localhost;
mysql> FLUSH PRIVILEGES;
mysql> Exit

# Installing WordPress
cd /var/www/
sudo wget http://wordpress.org/latest.tar.gz
sudo tar xzvf latest.tar.gz
cd /var/www/wordpress
sudo cp wp-config-sample.php wp-config.php

```

## Настроить в nginx кэш по условиям: кэшировать только те запросы, где есть utm_source=
```
# Add to nginx.conf
    proxy_cache_path /var/www/cache levels=1:2 keys_zone=my-cache:8m inactive=60m max_size=40m;
    proxy_cache_key "$scheme$request_method$host$request_uri";

# Use nginx config file (dir: nginx-conf/nginx80)

```

## Проверить, настроена ли ротация логов
```
/etc/logrotate.conf

```
## Configuring cron
```
# Created automaticaly (dir: virtual-host\user-data.sh)
echo "12 2 * * * root find /tmp -depth -mtime +14 -size +5 -exec rm -rf {} \;" >> /etc/crontab

```

## Cкрыть версии nginx, php на серверах
```
/etc/php/8.1/fpm/php.ini
expose_php = Off;
sudo systemctl restart php8.1-fpm

/etc/nginx/sites-available/nginx80
server_tokens off;
sudo nginx -s reload

 # Clear cached detections Wappalyzer
```

<img src="./images/with_versions.png"><br>
<img src="./images/without_versions.png"><br>

