killall dnsmasq
echo "nameserver 192.168.1.103" > /etc/resolv.conf
/usr/sbin/dnsmasq -C /tmp/dnsmasq.conf -r /etc/resolv.conf

