#!/bin/bash

cat > /myscripts/myconfig/nginx.conf <<'EOF'
user www-data;
worker_processes auto;
worker_cpu_affinity auto;
pid /tmp/nginx.pid;
error_log /myscripts/mylogs/error.log;

events { worker_connections 768; }

http {
	server {
		listen 80;
		server_name www.netics.my.id;
		
		location /web1 {
			proxy_pass http://192.168.200.20:8080/;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
		}

        location /web2 {
			proxy_pass http://192.168.200.21:8080/;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
		}

        location /app {
			proxy_pass http://192.168.200.21:5000/;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
		}
	}
}
EOF

cat > /myscripts/myconfig/start_http.sh <<'EOF'
#!/bin/bash
nginx -c /myscripts/myconfig/nginx.conf -g 'daemon off;'
EOF
