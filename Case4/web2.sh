#!/bin/bash

mkdir -p /myscripts/myconfig
mkdir -p /myscripts/myweb
mkdir -p /myscripts/mylogs

cat > /myscripts/myweb/index.html <<'EOF'
<html>
	<head>
		<title>This is My Web</title>
	</head>
	<body>
		<p>
		Ini WEB-2
		</p>
	</body>
</html>
EOF

cat > /myscripts/myconfig/nginx.conf <<'EOF'
user www-data;
worker_processes auto;
worker_cpu_affinity auto;
pid /tmp/nginx.pid;
error_log /myscripts/mylogs/error.log;

events { worker_connections 768; }

http {
	server {
		listen 8080;
		server_name netics.my.id;
		
		root /myscripts/myweb;
		index index.html;
		
		location / {
			try_files $uri $uri/ =404;
		}
	}
}
EOF

cat > /myscripts/myconfig/start_http.sh <<'EOF'
#!/bin/bash
nginx -c /myscripts/myconfig/nginx.conf -g 'daemon off;'
EOF
