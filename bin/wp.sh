#!/bin/bash

export XDEBUG_HOST=$(ipconfig getifaddr en0) # Specific to Macintosh
docker-compose exec --user www-data phpfpm wp "$@"