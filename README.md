# Dockerized Wordpress Setup for Cloud VM

This setup includes:
* Mariadb 10
* Wordpress 5
* Nginx for reverse proxy and SSL
* Let's Encrypt SSL certificate

## Prerequisites

1. Docker and docker-compose are installed

2. DNS record pointing to your VM

3. `aws` CLI

Also check out my cloud-init setup [here](https://github.com/MichaelKim0407/my-cloud-init-configs/blob/master/ubuntu.yml).

## Installation

1. Clone this repo

2. Run `install.sh` with the following environment variables:
    * `INSTALL_DIR`: the `docker-compose` directory that you will be using
    * `WP_HOSTNAME`: the hostname of your website (= DNS record)
    * `COMPOSE_PROJECT_NAME`: project name; optional, default to basename of `INSTALL_DIR`

    You may run the command like this:

    ```
    INSTALL_DIR=<install dir> WP_HOSTNAME=<hostname> COMPOSE_PROJECT_NAME=<project name> ./install.sh
    ```

    You will be prompted during SSL certificate generation.

3. Add a cron job to renew your certificate (see below)

4. Add a cron job to backup your website (see below)

## Alternative installation without SSL

(If you know what you are doing...)

Use `install-no-ssl.sh` instead.

## Certificate renewal

To manually renew your certificate, go to your `INSTALL_DIR` and run

```
bin/renew-cert.sh
```

You may set up a cron job to automatically renew your certificate.

## Backup

You must have aws CLI installed, and an s3 bucket accessible from your VM.
If you are using EC2, the easiest way is to attach an IAM role to your VM.

To manually backup your website, go to your `INSTALL_DIR` and run

```
sudo bin/backup.sh <s3 bucket name>
```

The backup will include:
* Your installation folder
* All docker volumes in your installation

You may set up a cron job to automatically backup your website.
