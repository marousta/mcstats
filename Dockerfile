############################
FROM node:lts AS yarn

RUN apt-get update
RUN apt-get install -y wget

RUN mkdir -p /apps

WORKDIR /app

############################
FROM yarn AS backend

RUN apt-get install -y postgresql-client

EXPOSE 3000

############################
FROM yarn AS frontend

EXPOSE 3000

############################
FROM ubuntu:20.04 AS nginx

RUN apt-get update
RUN apt-get install -y nginx openssl
RUN openssl ecparam -name secp384r1 -genkey -out /etc/nginx/cert.key \
	&& openssl req -x509 -out /etc/nginx/cert.crt -new -key /etc/nginx/cert.key -nodes -days 365 -subj '/C=US/L=Springfield/O=0/OU=localhost/CN=localhost'

EXPOSE 443
