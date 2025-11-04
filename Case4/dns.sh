#!/bin/bash

cat > /myscripts/dns/named.conf <<'EOF'
options {
	directory "/myscripts/dns";
	listen-on { any; };
	allow-query { any; };
    dnssec-validation no;
};

zone "localhost" {
	type master;
	file "db.localhost";
};

zone "netics.my.id" {
	type master;
	file "db.netics.my.id";
};
EOF

cat > /myscripts/dns/db.localhost <<'EOF'
$TTL 86400
@   IN  SOA localhost. root.localhost. (
        1		    ; serial 
        3600        ; refresh
        1800        ; retry
        604800      ; expire
        86400    )   ; minimum 

	IN  NS  localhost.
    IN  A   127.0.0.1
EOF
	
cat > /myscripts/dns/db.netics.my.id <<'EOF'
$TTL 86400
@   IN  SOA ns1.netics.my.id. admin.netics.my.id. (
        1		    ; serial 
        3600        ; refresh
        1800        ; retry
        604800      ; expire
        86400    )   ; minimum

	IN  NS  ns1.netics.my.id.
ns1     IN  A   192.168.200.12
@       IN  A   192.168.200.11
EOF

cat > /myscripts/dns/start_dns.sh <<'EOF'
#!/bin/sh
named -g -c /myscripts/dns/named.conf
EOF