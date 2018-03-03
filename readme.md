# WordPress Docker Development Environment

This is a Docker based local development environment for WordPress.

## What's Inside

This project is based on [WP Local Docker by 10up](https://github.com/10up/wp-local-docker) and [docker-compose](https://docs.docker.com/compose/). 

By default, the following containers are started: PHP-FPM, MariaDB, Apache, and Redis. 

The `/wordpress` directory is the web root which is mapped to the Apache and PHP containers.

[Custom php and apache images](https://github.com/ChrisWiegman/docker-images) are used for this environment.

## Requirements

* [Docker](https://www.docker.com/)
* [docker-compose](https://docs.docker.com/compose/)

## Setup

1. `git clone https://github.com/ChrisWiegman/docker-wordpress <my-project-name>`
2. `cd <my-project-name>`
3. `./develop up`
4. Run setup to download WordPress and create a `wp-config.php` file.
	1. On Linux / Unix / OSX, run `.bin/setup`.
5. Navigate to `http://localhost` in a browser to access your WordPress site.
	1. If you want to use a domain other than `http://localhost`, you'll need to add an entry to your hosts file. Ex: `127.0.0.1 docker.dev`

Default MySQL connection information (from within PHP-FPM container):

```
Database: wordpress
Username: wordpress
Password: password
Host: mysql
```

Default WordPress site information:

```
Username: admin
Password: password
```

## Docker Compose Overrides File

Adding a `docker-compose.override.yml` file alongside the `docker-compose.yml` file, with contents similar to
the following, allows you to change the domain associated with the cluster while retaining the ability to pull in changes from the repo.

```
version: '3'
services:
  phpfpm:
    extra_hosts:
      - "dashboard.dev:172.18.0.1"
  elasticsearch:
    environment:
      ES_JAVA_OPTS: "-Xms2g -Xmx2g"
```

## WP-CLI

There is also a script in the `/bin` directory that will allow you to execute WP CLI from the project directory directly: `./bin/wp plugin install`.

## SSH Access

Alternatively, there is a script in the `/bin` directory that allows you to SSH in to the environment from the project directory directly: `./bin/shell`.

## MailCatcher

MailCatcher runs a simple local SMTP server which catches any message sent to it, and displays it in it's built-in web interface. All emails sent by WordPress will be intercepted by MailCatcher. To view emails in the MailCatcher web interface, navigate to `http://localhost:1080` in your web browser of choice.

## Credits

This project is based off of [similar work](https://github.com/10up/wp-local-docker) by [10up](https://10up)
