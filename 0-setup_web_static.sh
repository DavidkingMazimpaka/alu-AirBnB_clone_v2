#!/usr/bin/env bash
# Configure your Nginx server so that
apt-get update
apt-get -y install nginx

directories=("/data/web_static/releases/" "/data/web_static/shared/")

for directory in "${directories[@]}";
do
    mkdir -p $directory
done

echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" >/data/web_static/releases/test/index.html

#Create a symbolic link to /data/web_static/current
ln -sf /data/web_static/releases/test/ /data/web_static/current

# recursively to all files and directories within the folder
chown -R ubuntu:ubuntu /data/

sed -i '/listen 80 default_server;/a \ \n    location /hbnb_static {\n        alias /data/web_static/current/;\n        index index.html;\n    }' /etc/nginx/sites-available/default

service nginx restart
