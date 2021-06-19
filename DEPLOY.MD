# Deploying to staging and production automatically from github using webhooks

## Introduction
This deploy script uses github webhooks to automatically deploy.

## Install the script
Edit the 2 paths to point to the root of your websites. Place this script in a web accessible location in your website.

## To create a deployment webhook in github
* Log into github
* Go to Settings
* click on webhook on the left menu
* Click add webhook
* Enter the URL to where you uploaded the deploy.php script
* Enter the secret/deploy_key (make a note of this you will need it in the next step)
* Click the Add Webhook button

Repeat these steps for staging and production/main

## To set the secret / deploy_key on your webserver.

On an NGINX server I do this in the vhost file in the php section.

```
fastcgi_param GIT_ENV "production";
fastcgi_param GITHUB_DEPLOY_KEY "<deploy key here>";
```

I can't cover all the other web server or methods to set per site env variables but it should be straight forward for the others.

## To get it working.
You need to do the initial clone/pull manually.  But after this anytime you push to main or staging you will trigger the deploy.php script.

This will then cd to the correct directory based on the GIT_ENV and will use the correct GITHUB_DEPLOY_KEY
