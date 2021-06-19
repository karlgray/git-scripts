<?php

$headers = getallheaders();
$signature = $headers['X-Hub-Signature-256'];
$postdata = file_get_contents("php://input");

define('GITHUB_DEPLOY_KEY', $_SERVER['GITHUB_DEPLOY_KEY']);

define('ENVIRONMENT', $_SERVER['GIT_ENV']);

switch (ENVIRONMENT)
{
	case 'development':

	break;
	case 'staging':
		$path = '<path to staging server>';
		$branch = 'staging';
	break;

	case 'production':
		$path = <'path to production/main server>';
		$branch = 'main';
	break;
}

echo "Checking signature: ";
if ( hash_equals('sha256=' . hash_hmac('sha256', $postdata, GITHUB_DEPLOY_KEY), $signature ))
{
	echo "Signature Matches\n";
}
else
{
	echo "Signature FAILED.  \n You are not authorised to pull on this server";
	// Do NOT pull and exit optionally add mail() to send email or log();
	exit;
}

// Execute github pull and echo output for github to log.
echo "Performing Pull.\nResponse from git pull\n\n";

$output = shell_exec("cd $path; git checkout $branch; git pull 2>&1;");
echo $output;