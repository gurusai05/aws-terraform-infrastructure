#!/bin/bash
set -euxo pipefail
# Amazon Linux 2023 uses dnf. Install and enable a simple demonstration service.
dnf install -y nginx
cat > /usr/share/nginx/html/index.html <<'HTML'
<!doctype html>
<html lang="en">
<head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Terraform AWS Demo</title></head>
<body><h1>Infrastructure provisioned with Terraform</h1><p>Amazon Linux 2023 + Nginx on EC2.</p></body>
</html>
HTML
systemctl enable --now nginx
