#!/bin/bash
versionname="1.0.0"
ACTION=${1}

function update() {
sudo yum update -y
sudo amazon-linux-extras install nginx1.12 -y
ps ax | grep nginx | grep -v grep
sudo service nginx start
sudo chkconfig nginx on
sudo aws s3 cp s3://ravin013-assignment-webserver/index.html /usr/share/nginx/index.html
}

function removeservice() {
sudo service nginx stop
sudo rm -f /usr/share/nginx/html/index.html
sudo yum remove nginx -y
}

function showversion() {
echo "Version of script is : $versionname"
}

function displayhelp() {
cat << EOF
Usage: ${0} {-r|--remove|-h|--help} <filename>
OPTIONS:
-h|--help will display the help page.
-r|--remove will remove the nginx server.
-v|--version will display the version.
-s|--service will update with nginx server.
Examples:
	Display help:
		$ ${0} -h
EOF
}
case "$ACTION" in
	-h|--help)
        	displayhelp
		;;
	-r|--remove)
		removeservice
		;;
	-v|--version)
		showversion
		;;
        -s|--service)
		update
		;;
	*)
	echo "Usage ${0} {-r|-h|-v}"
	exit
esac
