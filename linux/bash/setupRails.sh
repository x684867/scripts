#!/bin/bash
#
# setupRails.sh
# (c) 2012 Sam Caldwell.  Public Domain.
#
# This script will perform a setup for Ruby on Rails
# on an Ubuntu Linux server.  It should also work on
# a desktop.
#
[ ! -z "$1" ] && {
	[ "$1" == "-h" ] || [ "$1" == "--help" ] && {
		echo " "
		echo "This script will setup Ruby on Rails"
		echo "for Ubuntu Linux Server."
		echo " "
		echo "No inputs are needed."
		echo " "
	}
}
echo "Starting..."
echo " "
ANSWER=""
while [ -z "$ANSWER" ]; do
	read -p "Has the system been updated yet?" ANSWER
	ANSWER="$(echo $ANSWER | tr A-Z a-z | tr -dc yn | head -c 1)"
done
[ -z "$ANSWER" ] && echo "Unexpected input." && exit 1
[ "$ANSWER" == "n" ] && {
	echo " "
	echo "Performing system update before installing."
	echo " "
	sudo apt-get update -y
	sudo apt-get upgrade -y
	echo " "
	echo "-----------------------------------------"
	echo "This computer will restart in 10 seconds."
	echo "Please login and run this script again to"
	echo "continue."
	echo "-----------------------------------------"
	echo " "
	sleep 5 && shutdown -r now
}
echo "Continuing with installation."

apt-get install apache2 -y && [ "$?" != "0" ] && echo "failed." && exit 1

/etc/init.d/apache2 restart && [ "$?" != "0" ] && echo "failed." && exit 1

apt-get install ruby1.9.3 mysql-server make gcc gcc++ libcurl4-openssl-dev libssl-dev zlib1g-dev apache2-prefork-dev libapr1-dev libaprutil1-dev -y

gem install rake rails passenger && [ "$?" != "0" ] && echo "failed." && exit 1

passenger-install-apache2-module -a | egrep "^Apache\ configuration\ file\ and\ set\ its\ DocumentRoot\ to\ " -A 12 | tail -n 11 > /etc/apache2/sites-available/RubyOnRails

echo "You must now configure your Apache Configuration vhost file."
echo "This is located at /etc/apache2/sites-available/RubyOnRails"
echo "Then enable the vhost and restart apache."
exit 0
