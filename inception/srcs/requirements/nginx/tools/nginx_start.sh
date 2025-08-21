#!/usr/bin/env bash

mkdir -p "$CERT_DIR"
openssl req -x509 -newkey rsa:2048 -days 365 -nodes \
         -keyout "$CERT_KEY" \
         -out "$CERT" \
         -subj "/CN=$HOST_NAME"

mkdir -p "$(dirname "$NGINX_CONF")"
cat > "$NGINX_CONF" <<EOF
server {
    listen 443 ssl http2;
    server_name $HOST_LOGIN;

    root $WP_ROUTE;
    index index.php;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_certificate $CERT;
    ssl_certificate_key $CERT_KEY;

    location / {
        try_files \$uri \$uri/ /index.php?\$args =404;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass wordpress:9000;
    }
}
EOF
