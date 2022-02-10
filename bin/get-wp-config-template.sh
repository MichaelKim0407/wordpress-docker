#!/bin/bash

docker-compose run --rm --no-deps -T wp cat /usr/src/wordpress/wp-config-docker.php
