#!/bin/sh

fun_laravelChat() {
	cd $HOME/www/Chat && php artisan serve
}

fun_chatServer() {
	cd $HOME/www/Chat && node server.js
}

declare -A services

services[startmysql]="sudo /opt/lampp/lampp startmysql"
services[mysql]="sudo /opt/lampp/bin/mysql -u root"
services[laravelChat]=fun_laravelChat
services[chatServer]=fun_chatServer
services[removewifi]="sudo modprobe -r iwl3945"
services[loadwifi]="sudo modprobe -i iwl3945"

fun_help() {
	for key in ${!services[@]}; do
		echo ${key}
	done
}

services[help]=fun_help

if [ $# -eq 0 ]; then
	echo "You need to provided an argument"
elif [ -v services[$1] ]; then
	${services[$1]}
else
	echo "The service $1 does not exists"
fi
