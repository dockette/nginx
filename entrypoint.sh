#!/bin/bash

DHFILE='/etc/nginx/dhparam2048.pem'

if [ ! -f $DHFILE ] ; then
	echo 'Generating 2048bit dhparam'
	sh /generate-dhparam2048.sh
	mv /dhparam2048.pem $DHFILE
fi

nginx
