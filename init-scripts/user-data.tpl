#!/usr/bin/env bash
yum update -y
yum install vim unzip httpd -y
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

sudo bash -c 'cat <<EOF>> /var/www/html/index.html
<html>
<head><title>Sample Site</title></head>
<body>
  <h1>This is a WebServer ID => `curl -s http://169.254.169.254/latest/meta-data/instance-id`</h1>
</body>
</html>
EOF'

systemctl enable httpd
systemctl start httpd
