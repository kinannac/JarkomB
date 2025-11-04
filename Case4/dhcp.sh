#!/bin/bash

cat > /myscripts/dhcpd.conf <<'EOF'
start			192.168.200.100
end			    192.168.200.150
interface		eth0
max_leases		50
pidfile			/tmp/dhcpd.pid
lease_file		/tmp/dhcpd.leases
option subnet	255.255.255.0
option domain	netics.my.id
option dns      192.168.200.12
EOF

cat > /myscripts/start_dhcpd.sh <<'EOF'
#!/bin/bash
touch /tmp/dhcpd.leases
udhcpd -f /myscripts/dhcpd.conf
EOF
