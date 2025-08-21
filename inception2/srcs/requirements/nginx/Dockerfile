FROM debian:bookworm

RUN apt-get -y update && apt-get install -y nginx && apt-get upgrade -y openssl 
 
COPY ./requirements/nginx/tools/nginx_start.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/nginx_start.sh

ENTRYPOINT ["/usr/local/bin/nginx_start.sh"]
