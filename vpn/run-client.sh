#!/bin/sh

WGNAME=wgclient
NETWORK_INT=wg2
NETWORK_IP=10.1.2.68
NETWORK_NETWORK=${NETWORK_IP}/32
WGCONFIG=$(pwd)/client

docker stop $WGNAME
docker container rm $WGNAME

docker run -d --net=host \
	--name=$WGNAME \
	--cap-add=NET_ADMIN \
	--cap-add=SYS_MODULE \
	-e NETWORK_INT=$NETWORK_INT \
	-e NETWORK_IP=$NETWORK_IP \
	-e NETWORK_NETWORK=$NETWORK_NETWORK \
	-e TZ=Europe/Athens \
	-v $WGCONFIG:/settingsclient \
	-v /lib/modules:/lib/modules \
	hub.swarmlab.io:5480/venus-alpinewg:latest

# run ifup_linux in container
docker exec wgclient sh /settingsclient/ifup_linux
